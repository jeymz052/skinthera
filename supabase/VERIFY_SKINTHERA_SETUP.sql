-- Run after every migration through 20261024_skinthera_staff_roles.sql.

select clinic_name,doctor_name,contact_email,contact_phone,address,city,province,postal_code
from public.clinic_settings where id=1;

select c.name as category,s.name as service,s.slug,s.price,s.price_note,s.is_active
from public.services s
join public.service_categories c on c.id=s.category_id
where s.is_active=true
order by c.sort_order,s.sort_order;

select count(*) as active_packages from public.products where is_active=true;

select day_of_week,open_time,close_time,is_active
from public.availability_schedules order by day_of_week;

select pg_get_constraintdef(oid) as allowed_profile_roles
from pg_constraint
where conrelid='public.profiles'::regclass and conname='profiles_role_check';

select id,email,full_name,role from public.profiles order by role,email;

-- Expected:
-- clinic_name = Skinthera Medical Aesthetic
-- 7 active services: 2 consultations and 5 medical-treatment entries
-- active_packages = 0
-- Every day = 10:00-19:00 active; Sunday is advance-appointment-only
-- roles limited to superadmin, doctor, and patient
