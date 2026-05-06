resource "keycloak_realm" "distance_xt" {
  realm        = "distance-xt"
  enabled      = true
  display_name = "DISTANCE XT"
}

resource "keycloak_openid_client" "tx_frontend" {
  realm_id  = keycloak_realm.distance_xt.id
  client_id = "tx-frontend"
  name      = "Terminology Server Frontend"

  root_url            = "https://tx.distance-xt.life.uni-leipzig.local/fhir"
  valid_redirect_uris = ["https://tx.distance-xt.life.uni-leipzig.local/fhir/*"]

  access_type           = "CONFIDENTIAL"
  standard_flow_enabled = true
}

resource "keycloak_openid_audience_protocol_mapper" "tx_frontend_audience" {
  realm_id                 = keycloak_realm.distance_xt.id
  client_id                = keycloak_openid_client.tx_frontend.id
  name                     = "term-server"
  included_custom_audience = "term-server"
  add_to_id_token          = false
}
