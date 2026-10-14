-- Remove legacy doctor and clinic branding from records that may already exist.
update public.clinic_settings set
  clinic_name = 'Skinthera Medical Aesthetic',
  doctor_name = 'Dr. Clench Jane A. Zambrano, RMT & Dr. Angelo G. Zambrano, RRT',
  contact_phone = '0969 487 2272',
  address = 'Jameela Building, Corner National Highway & Katungal Road, Brgy. EJC',
  city = 'Tacurong City',
  province = 'Sultan Kudarat',
  postal_code = '9800',
  updated_at = now()
where id = 1;

update public.landing_content set
  content = coalesce(content, '{}'::jsonb) || jsonb_build_object(
    'doctorName', 'Dr. Clench Jane A. Zambrano, RMT & Dr. Angelo G. Zambrano, RRT',
    'doctorTitle', 'Aesthetic & Regenerative Medicine',
    'contactEyebrow', 'Contact Skinthera',
    'phone', '0969 487 2272',
    'address', 'Jameela Building, Corner National Highway & Katungal Road, Brgy. EJC, Tacurong City, Philippines 9800',
    'facebookPageUrl', 'https://www.facebook.com/profile.php?id=61591722818218'
  ),
  updated_at = now()
where id = 1;

update public.profiles set
  full_name = case lower(email)
    when 'clenchjanezambrano@gmail.com' then 'Dr. Clench Jane A. Zambrano, RMT'
    when 'angelozambrano@gmail.com' then 'Dr. Angelo G. Zambrano, RRT'
    else full_name
  end,
  updated_at = now()
where lower(email) in ('clenchjanezambrano@gmail.com', 'angelozambrano@gmail.com');

update auth.users set raw_user_meta_data = coalesce(raw_user_meta_data, '{}'::jsonb) || jsonb_build_object(
  'full_name', case lower(email)
    when 'clenchjanezambrano@gmail.com' then 'Dr. Clench Jane A. Zambrano, RMT'
    when 'angelozambrano@gmail.com' then 'Dr. Angelo G. Zambrano, RRT'
  end
)
where lower(email) in ('clenchjanezambrano@gmail.com', 'angelozambrano@gmail.com');

update public.services
set description = replace(replace(description, 'Dr. Kharyl', 'a Skinthera doctor'), 'The Klinique', 'Skinthera')
where description ilike '%Dr. Kharyl%' or description ilike '%The Klinique%';

update public.treatment_protocols
set postcare_instructions = replace(postcare_instructions, 'The Klinique', 'Skinthera'),
    updated_at = now()
where postcare_instructions ilike '%The Klinique%';
