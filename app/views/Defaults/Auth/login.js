$(document).ready(function () {
  select2data();
});
var currentURL = window.location.href;
var parts = currentURL.split("/");
console.log(parts);

function select2data() {
  $(".select2pdam").select2({
    allowClear: true,
    theme: "bootstrap4",
    width: "100%",
    ajax: {
      url: "{{ url('panel/referensi/getPdam') }}",
      data: function (params) {
        return {
          q: params.term,
          page: params.page || 1,
        };
      },
      processResults: function (response) {
        var data = JSON.parse(response);
        console.log(data);
        return {
          results: data.data.map(function (i) {
            i.id = i.username;
            i.text = i.nama_pdam;

            return i;
          }),
          pagination: {
            more: data.has_more,
          },
        };
      },
    },
  });
}
