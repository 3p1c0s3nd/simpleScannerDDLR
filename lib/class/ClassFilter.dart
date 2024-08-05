class ClassFilter {
  final Set<String> processedUrls = Set<String>();

  bool isSameDomain(String url1, String url2) {
    final RegExp regex = RegExp(r'^https?://(?:[^/]+\.)?([^/]+)');
    final match1 = regex.firstMatch(url1);
    final match2 = regex.firstMatch(url2);

    return match1 != null &&
        match2 != null &&
        match1.group(1) == match2.group(1);
  }

  bool shouldProcessUrl(String url) {
    if (processedUrls.contains(url)) {
      return false;
    }

    for (var processedUrl in processedUrls) {
      if (isSameDomain(url, processedUrl)) {
        return false;
      }
    }

    processedUrls.add(url);
    return true;
  }
}
