-- Compatibility repair for the existing supabaselab public.profiles table.
do $$
begin
  if not exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'profiles'
      and column_name = 'fullname'
  ) or exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'profiles'
      and column_name = 'full_name'
  ) or not exists (
    select 1 from pg_trigger
    where tgrelid = 'auth.users'::regclass
      and tgname = 'on_auth_user_created'
      and tgfoid = 'public.handle_new_user()'::regprocedure
      and not tgisinternal
  ) then
    raise exception 'O esquema legado não corresponde ao esperado em supabaselab';
  end if;
end;
$$;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.profiles (id, fullname, avatar_url)
  values (new.id, new.raw_app_meta_data ->> 'fullname', new.raw_user_meta_data ->> 'avatar_url');
  return new;
end;
$$;
