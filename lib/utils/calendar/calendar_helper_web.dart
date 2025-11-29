import 'dart:convert';
import 'dart:html' as html;

void downloadIcsFile(String content) {
  final bytes = utf8.encode(content);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "invite.ics")
    ..click();
  html.Url.revokeObjectUrl(url);
}
