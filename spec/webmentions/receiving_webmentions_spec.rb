RSpec.describe "Receiving Webmentions" do
  context "when receiving a POST request containing `source` and `target` parameters" do
    it "SHOULD verify the parameters"
    it "SHOULD queue and process the Webmention asynchronously (to prevent DoS attacks)"

    context "with a status page for the Webmention" do
      it "MUST reply with a 201 created with a Location header pointing to the Status URL"
    end
    context "without a status page for the Webmention" do
      it "MUST reply with a 202 accepted"
    end

    describe "Request verification" do
      it "MUST check that the source and target URLs are valid URLs"
      it "MUST check thata the URL schemes are supported by the receiver"

      context "when the source and target URLs are the same" do
        it "MUST reject the request"
        it "SHOULD synchronously check that the target is a valid resource for which it can accept Webmentions"
      end
    end

    describe "Webmention verification" do
      it "SHOULD happen asynchronously to prevent DoS attacks"
      context "when the receiver is going to use the Webmention" do
        it "MUST perform an HTTP GET request on the source URL"
        it "MUST follow a number of redirects"
        it "MUST confirm that the source URL actually mentions the target URL exactly"
        it "SHOULD use per-media-type rules to determine if the source mentions the target"
      end
    end
    describe "Error Responses" do
      context "when the Webmention was not successful because of something the _sender_ did" do
        it "MUST return a 400 Bad Request"
      end
      context "when the Webmention was not successful because of something the _receiver_ did" do
        it "SHOULD return a 500 Internal Server Error"
        it "MAY include a description of the error in the response body"
      end
    end
    describe "Updating existing Webmentions" do
      context "when the receiver has received a Webmention in the past for the same `source` and `target`" do
        context "when both verification steps are successful" do
          it "SHOULD update any existing data it picked from the source for the existing Webmention"
        end
        context "when the source URL returns a 410 Gone status code" do
          it "SHOULD delete the existing Webmention"
        end
        context "when the source URL returns a 200 OK and has no mention of the target" do
          it "SHOULD delete the existing Webmention"
        end
        it "should be idempotent when processing mulitple Webmentions for the same source and target with no content changes"
      end
    end
  end
end
