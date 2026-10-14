# Fresh Skinthera Supabase setup

The files in `migrations/` are the complete Skinthera database schema. Supabase
applies them in filename order and records each applied migration, so they act as
one reproducible setup even though the schema is split into maintainable files.

## Recommended: Supabase CLI

From the project root:

```powershell
npx supabase login
npx supabase link --project-ref YOUR_PROJECT_REF
npx supabase db push
```

This creates the booking catalog, appointments, profiles and roles, schedules,
notifications, EMR tables, consultation and treatment workflows, clinic
settings, landing-page CMS, storage bucket, blog builder, intake questions,
RLS policies, and the final Skinthera services and branding.

Do not run only the last migration. Finish with
`20261024_skinthera_staff_roles.sql`, which depends on the earlier schema.

## First staff account

Run every migration before creating the two temporary doctor accounts. The
historical cleanup migration is safe on an empty Auth project but should not be
used after adding temporary users.

1. In Authentication > Users, create `estebanjames67@gmail.com`. The final
   migration automatically makes this account the protected superadministrator.
2. In Authentication > Users, manually create one account for each doctor with
   a temporary password. Use real email addresses that the doctors can access
   for password recovery.
3. Promote the two doctor profiles in the SQL editor:

```sql
update public.profiles set role='doctor',updated_at=now()
where lower(email) in (lower('FIRST_DOCTOR_EMAIL'),lower('SECOND_DOCTOR_EMAIL'));
```

Confirm that this updated two rows. Staff roles are limited to `superadmin` and
`doctor`; all other users are patients. Never store temporary passwords in a
migration or committed project file.

## Required application environment variables

Copy the values from Supabase Project Settings > API into `.env.local`:

```text
NEXT_PUBLIC_SUPABASE_URL=https://YOUR_PROJECT_REF.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=YOUR_ANON_KEY
SUPABASE_SERVICE_ROLE_KEY=YOUR_SERVICE_ROLE_KEY
```

Keep the service-role key server-side and never expose it in browser code.
