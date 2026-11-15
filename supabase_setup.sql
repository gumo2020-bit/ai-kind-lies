-- Supabase 대시보드 > SQL Editor에 전체 붙여 넣어 실행하세요.
-- 응답 개별 내용은 외부에서 조회할 수 없고, 익명 선택 건수만 공개합니다.

create table if not exists public.responses (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  age_group text not null check (age_group in ('초등학생','중·고등학생','20대','30대','40대','50대 이상')),
  gender text check (gender in ('여성','남성','응답하지 않음')),
  choices text[] not null check (array_length(choices,1)=3 and choices <@ array['A','B']::text[]),
  reasons text[] not null check (array_length(reasons,1)=3 and
    length(reasons[1]) between 1 and 500 and
    length(reasons[2]) between 1 and 500 and
    length(reasons[3]) between 1 and 500)
);

alter table public.responses enable row level security;
revoke all on public.responses from anon, authenticated;
grant insert on public.responses to anon, authenticated;

drop policy if exists "allow anonymous survey insert" on public.responses;
create policy "allow anonymous survey insert" on public.responses
for insert to anon, authenticated with check (true);

-- 전체 원본 자료에 대한 SELECT 권한은 부여하지 않습니다.
-- 공개 함수는 결과 숫자만 반환하고 사용자별 내용은 반환하지 않습니다.
create or replace function public.get_choice_stats()
returns table (question_no integer, a_count bigint, b_count bigint, total_count bigint)
language sql security definer set search_path = ''
as $$
  select n as question_no,
         count(r.id) filter (where r.choices[n] = 'A') as a_count,
         count(r.id) filter (where r.choices[n] = 'B') as b_count,
         count(r.id) as total_count
  from generate_series(1,3) as n
  left join public.responses r on true
  group by n
  order by n;
$$;
revoke all on function public.get_choice_stats() from public;
grant execute on function public.get_choice_stats() to anon, authenticated;
