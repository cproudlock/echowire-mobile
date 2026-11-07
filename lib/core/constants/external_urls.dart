abstract final class ExternalUrls {
  static const String serviceStatus = 'https://echowire.instatus.com';
  static const String serviceStatusHistory = '$serviceStatus/history';
  static const String fluxerMarketing = 'https://fluxer.com';
  static const String fluxerPatchNotes = '$fluxerMarketing/patch-notes';
  static const String fluxerDownload = 'https://echowire.org/download';
  // Echowire: upstream links its App Store listing here; we have none, so this is our download page.
  static const String fluxerAppStore = 'https://echowire.org/download';
}
