# distance-xt-core

Shared services for the distance-xt platform, consumed by every `diz` instance.

Namespace: `distance-xt-core`

## Components

- **term-server** — Blaze configured as a terminology server (LOINC + SNOMED-CT), with frontend.
  - Backend: `https://tx.distance-xt.life.uni-leipzig.local/fhir`
- **keycloak** — OIDC for the platform.
  - `https://auth.distance-xt.life.uni-leipzig.local`
  - Realm (planned): `distance-xt`

## Required CI variables

The `credentials` secret is assembled by CI (`.app/apply` in `.gitlab-ci.yml`)
from these GitLab CI/CD variables:

- `KEYCLOAK_ADMIN_PASSWORD`
- `FRONTEND_AUTH_CLIENT_SECRET`
- `FRONTEND_AUTH_SECRET` (random, e.g. `openssl rand -hex 32`)

## Deploy

Via the shared kustomize CI component (`util/k8s-ci/kustomize@0.3.1`). The
`app/deploy:prod` job runs automatically on the default branch and on MRs
labelled `hint::autodeploy`; otherwise it's manual.

## SNOMED CT release

The term-server StatefulSet expects a SNOMED CT release directory at
`/app/data/SnomedCT_Germany-EditionRelease_PRODUCTION_20241115T120000Z`. Load it
into the `data` PVC before the pod can serve terminology requests.

## Open items

- SNOMED CT release version pinning and upload procedure.
- Keycloak realm + clients (`tx-frontend`, per-DIZ clients). Consider realm import instead of `start-dev`.
- Replace Keycloak `start-dev` + H2 with a production setup (external DB, `start`) before prod use.
