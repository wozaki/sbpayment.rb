require 'sbpayment'
require 'erb'
require 'pp'
require 'securerandom'

# There is "Connection Support Site" (接続支援サイト) in SBPS.
# Normally we send a request against Connection Support Site in these examples.
# However there is no url about routine endpoint :(
# Use given ROUTINE_ENTRY_ENDPOINT_URL instead.
ROUTINE_ENTRY_ENDPOINT_URL = 'https://xxxxxx'

Sbpayment.configure do |x|
  x.sandbox = true
  x.merchant_id = '19788'
  x.service_id  = '001'
  x.hashkey = '398a58952baf329cac5efbae97ea84ba17028d02'
end

req = Sbpayment::Link::RoutineEntry.new
req.pay_method       = 'softbank2'
req.cust_code        = SecureRandom.hex
req.order_id         = SecureRandom.hex
req.item_id          = 'Item ID'
req.item_name        = '継続課金'
req.service_type     = 0
req.success_url      = 'http://example.com/success'
req.cancel_url       = 'http://example.com/cancel'
req.error_url        = 'http://example.com/error'
req.pagecon_url      = 'http://example.com/callback'
req.update_sps_hashcode

File.write 'a.html', ERB.new(<<HTML).result
<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <script type="text/javascript">
if (document.charset !== "UTF-8") {
  document.charset = "UTF-8";
  location.reload();
}
document.addEventListener("DOMContentLoaded", function (event) {
  document.getElementById("submitBtn").addEventListener("click", function(event) {
    document.charset = "Shift_JIS";
    event.target.parentNode.acceptCharset = "Shift_JIS";
    event.target.parentNode.submit();
  }, false);
});
    </script>
  </head>
  <body>
   <form id="submitFrm" method="post" action="#{ROUTINE_ENTRY_ENDPOINT_URL}">
      <% req.attributes.each do |name, value|%>
        <% next if value == "" %>
        <input type="hidden" name="<%= name %>" value="<%= value.to_s %>">
      <% end %>
      <input id="submitBtn" type="submit">
    </form>
  </body>
</html>
HTML
