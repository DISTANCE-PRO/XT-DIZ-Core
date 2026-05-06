# DISTANCE:PRO XT — Core Services

Shared platform services consumed by every participating rollout partner (DIZ) in the DISTANCE:PRO XT network.

## Introduction

This repository deploys the central infrastructure that all sites depend on:

- **Terminology Server** — A [Blaze](https://github.com/samply/blaze) FHIR server configured to serve medical
  terminologies (LOINC and SNOMED CT). Provides a web frontend for browsing and querying terminology content.
- **Identity Provider** — A [Keycloak](https://www.keycloak.org/) instance providing single sign-on (OIDC) for the
  entire platform. All other services authenticate users and service accounts through this central identity provider.

## Technology

| Component          | Technology             | Purpose                              |
|--------------------|------------------------|--------------------------------------|
| Terminology Server | Blaze (FHIR R4)        | Serves LOINC + SNOMED CT terminology |
| Identity Provider  | Keycloak               | OpenID Connect authentication        |
| Orchestration      | Kubernetes / Kustomize | Deployment and configuration         |
| CI/CD              | GitLab CI              | Automated deployment pipeline        |

## Architecture Context

This is one of three repositories that make up the DISTANCE:PRO XT platform:

- **core** (this repo) — Shared terminology and authentication services
- **[trust-center](../trust-center)** — Consent management and pseudonymization
- **[diz](../diz)** — Per-site data integration (one instance per rollout partner)

## Keycloak Configuration (Terraform)

Keycloak resources are managed as code using the terraform and the official [Keycloak provider][keycloak-provider].
This replaces manual realm/client configuration via the Keycloak admin UI.

### Design

This repo owns the **realm** and any clients that belong to core services:

| Resource                             | Purpose                                                        |
|--------------------------------------|----------------------------------------------------------------|
| `keycloak_realm.distance_xt`         | The shared `distance-xt` realm used by all platform components |
| `keycloak_openid_client.tx_frontend` | OIDC client for the terminology server frontend                |

Other repos (e.g. trust-center) reference this realm via a `data` source, ensuring a single
source of truth for realm-level settings while allowing each repo to manage its own clients
and roles independently.

[keycloak-provider]: https://registry.terraform.io/providers/keycloak/keycloak/latest/docs
