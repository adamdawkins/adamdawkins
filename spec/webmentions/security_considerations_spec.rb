RSpec.describe "Webmention Security Considerations" do
  describe "Preventing abuse" do
    it "SHOULD process the verification process asynchronously to prevent DoS attacks"
    it "MUST verify received webmenions"
    it "MUST ensure displayed data from the source is encoded or filtered to prevent XSS and CSRF attacks"
    it "MAY moderate Webmentions before publishing them"
    it "MAY periodically re-verify Webmentions"
  end

  describe "Limits on GET requests" do
    it "MAY make an initial HEAD request when verifying the link and decide whether to make a full GET request after initially inspecting the content type, length or other HTTP headers"
    it "SHOULD place limits on the number of HTTP redirects to follow, in order to prevent being stuck in a redirect loop"
    it "SHOULD place limits on the amount of data and time they spend fetching unverified URLS"
  end
  describe "Avoiding sending Webmentions to localhost" do
   it "SHOULD NOT send Webmentions to localhost URLs"
  end
  describe "respecting cache headers on discovery" do
    context "when performing Webmention discovery" do
      it "SHOULD respect cache headers on the target URL and NOT fetch the URL more often than is indicated by the headers"
      end
  end
end
