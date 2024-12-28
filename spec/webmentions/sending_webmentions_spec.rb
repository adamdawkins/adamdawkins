RSpec.describe "sending Webmentions" do
  describe "Sender discovers receiever Webmention endpoint" do
    it "MUST fetch the target URL and check for an HTTP Link header with a rel value of `Webmention`"
    context "when the content type of the target URL is HTML" do
      it "MUST look for an html <link> tag with a rel value of `Webmention`"
      it "MUST look for an html <a> tag with a rel value of `Webmention`"
    end
    context "when the endpoint is a relative URL" do
      it "MUST resolve the URL relative to the target URL"
    end
    context "optional HEAD request" do
      it "may make a HEAD request to check for the Link header before making a GET request"
    end
    context "optional User Agent" do
      it "may send a custom User Agent to include the string 'Webmention'"
    end
  end
  describe "Sender notifies receiver" do
    it "MUST POST x-www-form-urlencoded source and target parameters to the Webmention endpoint, where `source` is the URL of the sender's page containing a link, and `target` is the URL of the page being linked to"
    context "when the Wembention endpoint URL contains query string parameters" do
      it "MUST preserve the query string parameters in the target URL"
      it "MUST NOT send the query string parameters in the POST body"
    end
    it "MUST consider any 2xx status code as a success"
  end
  describe "sending Webmentions for updated posts" do
    context "when the source URL is updated" do
      it "SHOULD re-send any previously sent Webmentions"
      context "when a URL has been removed from the document" do
        it "SHOULD re-send Webmentions to the removed URL"
      end
      it "MUST re-discover the Webmention endpoint"
    end
  end
  describe "sending Webmentions for deleted posts" do
    it "SHOULD return an HTTP 410 Gone status code for the URL"
    it "SHOULD display a 'tombstone' representation of the deleted post"
    it "SHOULD re-send Webmentions for every previously send Webmention for that document"
  end
end
