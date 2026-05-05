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
