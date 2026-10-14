-- Skinthera booking catalog and public information.
-- A price of 0 means "not published yet" and stays editable in Settings > Pricing.
-- Retire every legacy Klinique service. The Skinthera rows below are then
-- explicitly re-enabled, keeping old references safe without exposing them.
update public.services set is_active=false;
update public.products set is_active=false;

insert into public.service_categories(name,slug,sort_order) values
 ('Consultations','consultations',1),('Aesthetic Medicine','aesthetic-medicine',10),
 ('Regenerative Medicine','regenerative-medicine',20),('Weight Management','weight-management',30),
 ('Skin & Wellness','skin-wellness',40),('Laser Services','laser-services',50)
on conflict(slug) do update set name=excluded.name,sort_order=excluded.sort_order;

insert into public.services(category_id,name,slug,description,price,price_note,duration_mins,is_active,sort_order,subcategory)
select id,'Consultation','skinthera-consultation','In-clinic medical assessment and personalized care plan.',0,'Price available after consultation',30,true,1,'Consultation'
from public.service_categories where slug='consultations'
on conflict(slug) do update set category_id=excluded.category_id,name=excluded.name,description=excluded.description,price_note=excluded.price_note,duration_mins=excluded.duration_mins,is_active=true,sort_order=excluded.sort_order,subcategory=excluded.subcategory;

update public.clinic_settings set
 clinic_name='Skinthera Medical Aesthetic',
 doctor_name='Dr. Clench Jane A. Zambrano, RMT & Dr. Angelo G. Zambrano, RRT',
 contact_email='estebanjames67@gmail.com',
 contact_phone='0969 487 2272',
 address='Jameela Building, Corner National Highway & Katungal Road, Brgy. EJC',
 city='Tacurong City',province='Sultan Kudarat',postal_code='9800',
 accepts_walk_ins=false,updated_at=now()
where id=1;

-- Published clinic hours: Monday-Saturday, 10 AM-7 PM. Sunday slots are also
-- available for advance appointments; with no Sunday booking, the clinic closes.
insert into public.availability_schedules(day_of_week,open_time,close_time,is_active)
values
 (0,'10:00','19:00',true),(1,'10:00','19:00',true),
 (2,'10:00','19:00',true),(3,'10:00','19:00',true),
 (4,'10:00','19:00',true),(5,'10:00','19:00',true),
 (6,'10:00','19:00',true)
on conflict(day_of_week) do update set
 open_time=excluded.open_time,close_time=excluded.close_time,
 is_active=excluded.is_active,updated_at=now(),updated_by=null;

insert into public.services(category_id,name,slug,description,price,price_note,duration_mins,is_active,sort_order,subcategory)
select id,'Online Consultation','skinthera-online-consultation','Remote consultation with a Skinthera doctor.',0,'Price available after consultation',30,true,2,'Online Consultation'
from public.service_categories where slug='consultations'
on conflict(slug) do update set category_id=excluded.category_id,name=excluded.name,description=excluded.description,price_note=excluded.price_note,duration_mins=excluded.duration_mins,is_active=true,sort_order=excluded.sort_order,subcategory=excluded.subcategory;

insert into public.services(category_id,name,slug,description,price,price_note,duration_mins,is_active,sort_order,subcategory)
select c.id,v.name,v.slug,v.description,0,'Price available after consultation',60,true,1,'General'
from public.service_categories c join (values
 ('aesthetic-medicine','Aesthetic Medicine Treatment','skinthera-aesthetic-treatment','Doctor-led aesthetic treatment selected after assessment.'),
 ('regenerative-medicine','Regenerative Medicine Treatment','skinthera-regenerative-treatment','Personalized regenerative care selected after assessment.'),
 ('weight-management','Weight Management','skinthera-weight-management','Medical weight-management assessment and care.'),
 ('skin-wellness','Skin & Wellness Treatment','skinthera-skin-wellness','Personalized skin and wellness treatment.'),
 ('laser-services','Laser Treatment','skinthera-laser-treatment','Laser care selected according to your individual assessment.')
) as v(category_slug,name,slug,description) on v.category_slug=c.slug
on conflict(slug) do update set category_id=excluded.category_id,name=excluded.name,description=excluded.description,price_note=excluded.price_note,duration_mins=excluded.duration_mins,is_active=true,sort_order=excluded.sort_order,subcategory=excluded.subcategory;

update public.landing_content set content=coalesce(content,'{}'::jsonb)||jsonb_build_object(
 'heroEyebrow','Aesthetic & Regenerative Medicine','heroTitle','Care that begins with you.',
 'heroSubtitle','Medical expertise. Personalized care. Naturally you.',
 'heroDescription','Personalized aesthetic, regenerative, skin, laser, and weight-management care in Tacurong City.',
 'heroMedia',jsonb_build_array(
   jsonb_build_object('url','/images/skintherahero3.png','type','image','alt','Skinthera Medical Aesthetic'),
   jsonb_build_object('url','/images/skintherahero2.png','type','image','alt','Skinthera personalized care'),
   jsonb_build_object('url','/images/skintherahero5.png','type','image','alt','Skinthera aesthetic medicine'),
   jsonb_build_object('url','/images/skintherahero4.png','type','image','alt','Skinthera regenerative medicine'),
   jsonb_build_object('url','/images/skintherahero1.png','type','image','alt','Skinthera wellness care')),
 'aboutTitle','Science-led care, beautifully personal.',
 'aboutBody','Skinthera is a medical aesthetic clinic in Tacurong where clinical expertise meets a warm, considered experience.',
 'aboutImage','/images/skintherainteror1.jpg','doctorName','Dr. Clench Jane A. Zambrano, RMT & Dr. Angelo G. Zambrano, RRT',
 'doctorTitle','Aesthetic & Regenerative Medicine','facebookPageUrl','https://www.facebook.com/profile.php?id=61591722818218',
 'instagramUrl','','socialHeading','Follow Skinthera','socialPosts','[]'::jsonb,
 'contactEyebrow','Contact Skinthera','contactTitle','Your next chapter starts here.',
 'contactBody','Reach out for appointment help, service questions, or directions to the clinic.',
 'email','estebanjames67@gmail.com',
 'phone','0969 487 2272','address','Jameela Building, Corner National Highway & Katungal Road, Brgy. EJC, Tacurong City, Philippines 9800',
 'clinicHours','Monday–Saturday: 10:00 AM–7:00 PM. Advance booking only. Sunday by confirmed appointment; otherwise closed.',
 'footerTagline','Aesthetic & Regenerative Medicine'),updated_at=now() where id=1;
