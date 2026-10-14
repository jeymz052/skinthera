-- Final Skinthera staff model: one superadmin and doctor accounts only.
-- Patient remains the default public account role.
update public.profiles set role='patient',updated_at=now() where role='secretary';

drop trigger if exists enforce_secretary_seat_limit on public.profiles;
drop function if exists public.enforce_secretary_seat_limit();
drop policy if exists "Secretaries can read patient profiles" on public.profiles;

alter table public.profiles drop constraint if exists profiles_role_check;
alter table public.profiles add constraint profiles_role_check
  check(role in ('superadmin','doctor','patient'));

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path=pg_catalog,public
as $$
begin
  insert into public.profiles(id,email,full_name,role)
  values(new.id,new.email,coalesce(new.raw_user_meta_data->>'full_name',''),
    case when lower(coalesce(new.email,''))='estebanjames67@gmail.com' then 'superadmin'
         when new.raw_app_meta_data->>'role'='doctor' then 'doctor' else 'patient' end)
  on conflict(id) do update set email=excluded.email,
    full_name=coalesce(nullif(excluded.full_name,''),public.profiles.full_name),
    role=case when lower(coalesce(excluded.email,''))='estebanjames67@gmail.com' then 'superadmin' else public.profiles.role end,
    updated_at=now();
  return new;
end;
$$;

-- Sync users that existed before migration and assign approved staff emails.
insert into public.profiles(id,email,full_name,role)
select id,email,coalesce(raw_user_meta_data->>'full_name',''),
  case when lower(email)='estebanjames67@gmail.com' then 'superadmin'
       when lower(email) in ('angelozambrano@gmail.com','clenchjanezambrano@gmail.com') then 'doctor'
       else 'patient' end
from auth.users
on conflict(id) do update set
  email=excluded.email,
  full_name=coalesce(nullif(excluded.full_name,''),public.profiles.full_name),
  role=case when lower(excluded.email)='estebanjames67@gmail.com' then 'superadmin'
            when lower(excluded.email) in ('angelozambrano@gmail.com','clenchjanezambrano@gmail.com') then 'doctor'
            else public.profiles.role end,
  updated_at=now();

create or replace function public.assign_staff_role(target_email text,target_role text)
returns void language plpgsql security definer set search_path=pg_catalog,public
as $$
begin
  if public.current_user_role()<>'superadmin' then raise exception 'Not authorized'; end if;
  if target_role not in ('superadmin','doctor','patient') then raise exception 'Invalid assignable role'; end if;
  if lower(trim(target_email))='estebanjames67@gmail.com' and target_role<>'superadmin' then
    raise exception 'The owner account must remain superadmin';
  end if;
  update public.profiles set role=target_role,updated_at=now()
  where lower(email)=lower(trim(target_email));
  if not found then raise exception 'No profile found for that email'; end if;
end;
$$;

revoke all on function public.assign_staff_role(text,text) from public,anon;
grant execute on function public.assign_staff_role(text,text) to authenticated;
