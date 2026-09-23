/// Echowire: one switch governing whether this client registers itself for
/// relay-based encrypted web push, or keeps registering a raw provider token.
///
/// Upstream moved registration to an endpoint URL at their own relay host and
/// unregisters the raw token on the way, which on this instance would do three
/// unwanted things at once: break delivery, because our gateway sends directly
/// to FCM and APNs and cannot post to a relay that is not enabled; put our
/// users' device tokens inside URLs addressed to upstream infrastructure; and
/// discard the working raw registration that delivery currently depends on.
///
/// The server half (upstream #2906) is opt-in and ships disabled, so this stays
/// false until our own relay is deployed, enabled and adopted. Receiving is
/// unaffected either way: the FCM path decrypts when a ciphertext is present
/// and falls back to plaintext when it is not.
///
/// When the relay goes live, set this to true and set the relay origin in
/// web_push_relay.dart to our own host, never upstream's.
const bool kEchowireWebPushRegistrationEnabled = false;
