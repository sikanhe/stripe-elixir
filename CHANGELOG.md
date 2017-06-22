## 0.7.0 
- [Enhancement] Added ability to verify signed Stripe Webhook payloads via `Stripe.Webhook.construct_event/4`. (Thank you @jayjun)
- [Enhancement] Added ability to generate a Connect oauth url via `Stripe.Connect.authorize_url/1`.
- [Modification] Missing secret_key will now raise `Stripe.AuthenticationError` error instead of `MissingSecretKeyError`.