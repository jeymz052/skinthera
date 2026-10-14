-- Historical Klinique patient reset intentionally disabled for Skinthera.
-- A fresh Skinthera project may already contain its initial superadmin and
-- doctor Auth accounts before migrations are applied. Deleting Auth users from
-- a schema migration is unsafe, so this migration is retained as a no-op only
-- to preserve the established migration filename/order.

do $$
begin
  raise notice 'Legacy patient reset skipped for Skinthera.';
end;
$$;
