# AI의 친절한 거짓말 🌼

**제출용 주제명:** 진실과 배려 사이의 AI 윤리  
**사이트 제목:** AI의 친절한 거짓말  
**기술:** Vite + Vanilla JavaScript + Supabase + Vercel

## 구현한 기능
- 귀여운 로봇과 파스텔톤 반응형 첫 화면
- 연령대 선택, 성별 선택(선택사항), 익명 응답 활용 동의
- AI 윤리 딜레마 3문항 / A·B 선택과 이유 작성(필수)
- 나의 선택 해설과 대안적 관점 제시
- Supabase 연결 시 익명 응답 저장 및 누적 A·B 선택 비율 표시
- Supabase 미연결 시 체험 모드 (저장/공용 통계 없음)

## 1. 로컬에서 실행

Node.js 20 이상이 설치되어 있어야 합니다.

```bash
npm install
npm run dev
```

출력된 로컬 주소를 브라우저에서 열어 주세요. `npm run build`로 빌드를 확인할 수 있습니다.

## 2. Supabase 연결

1. https://supabase.com 에서 프로젝트를 생성합니다.
2. 프로젝트 > **SQL Editor**를 열고 `supabase_setup.sql` 전체를 붙여 넣고 실행합니다.
3. **Project Settings → API** 또는 프로젝트의 Connect 화면에서 **Project URL**과 **anon/public(또는 publishable) key**를 확인합니다. **service_role / secret key는 절대 프런트엔드에 넣지 마세요.**
4. 프로젝트 최상위 경로에 `.env.example`을 복사하여 `.env.local` 파일을 만들고 다음 항목을 입력합니다.

```env
VITE_SUPABASE_URL=https://YOUR-PROJECT.supabase.co
VITE_SUPABASE_ANON_KEY=YOUR-PUBLISHABLE-OR-ANON-KEY
```

5. 다시 `npm run dev`를 실행합니다. 상단 뱃지가 `응답 저장 연결`로 나타납니다.
6. 임의의 테스트 답안을 작성한 후 Supabase Table Editor에서 저장 여부를 확인합니다. 통계는 결과 화면에 표시됩니다.

**개인정보 주의:** 이름이나 연락처를 받지 않도록 설계했지만, 선택 이유 자유 입력란에 개인정보를 적지 않도록 안내하세요. 동의 문구가 실제 교육기관의 개인정보 처리 방침을 대신하지는 않습니다. 공개 전 담당 교사의 안내/기관 정책을 확인하세요.

## 3. GitHub 업로드

1. https://github.com 에 로그인해 **New repository**를 생성합니다 (예: `ai-kind-lies`).
2. **Add file → Upload files**를 선택합니다.
3. 이 압축을 푼 폴더의 **안쪽 파일들** (`src`, `public`, `index.html`, `package.json`, `supabase_setup.sql` 등)을 올립니다. `.env.local`, `node_modules`, `dist`는 업로드하지 않습니다.
4. **Commit changes**를 클릭합니다.

## 4. Vercel 배포

1. https://vercel.com 로그인 → **Add New → Project** → GitHub 저장소 가져오기.
2. Vite 프로젝트를 자동 인식했는지 확인합니다. Build Command는 `npm run build`, Output Directory는 `dist`입니다.
3. **Environment Variables**에 `VITE_SUPABASE_URL` 및 `VITE_SUPABASE_ANON_KEY`를 추가합니다. 값에 공백을 넣지 마세요.
4. **Deploy**를 누르고 생성된 `.vercel.app` 링크로 접속해 응답 저장과 통계를 테스트합니다.

> `.env.local`은 GitHub에 올리지 않습니다. Vite의 `VITE_` 변수는 최종 브라우저 코드에 포함되므로 공개 가능한 키만 입력해야 합니다. RLS 정책과 함수 권한으로 원본 응답 공개를 차단합니다.

## 제출 표 예시

- 사이트 링크: 배포 후 확인되는 `https://...vercel.app`
- 주제명: **진실과 배려 사이의 AI 윤리**

## 파일 구조

```text
ai-kind-lies/
├─ public/favicon.svg
├─ src/main.js
├─ src/style.css
├─ index.html
├─ package.json
├─ supabase_setup.sql
├─ .env.example
├─ .gitignore
└─ README.md
```
