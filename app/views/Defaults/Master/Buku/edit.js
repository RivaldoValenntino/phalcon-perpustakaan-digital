window.defaultUrl = `${baseUrl}/master/data-buku/`;
var i = 0;
var oldFile = "";
$(document).ready(function () {
  var dataId = {{ dataId }};
  select2data();
  $("#cover").change(function () {
    uploadFile();
  });
  let NamaPenulis = "{{ NamaPenulis }}";
  let NamaKategori = "{{ NamaKategori }}";
  let NamaPenerbit = "{{ NamaPenerbit }}";

  if (NamaPenulis) {
    var option = new Option(NamaPenulis, NamaPenulis, true, true);
    $("select[name=penulis]").append(option).trigger("change");
  }
  if (NamaKategori) {
    var option = new Option(NamaKategori, NamaKategori, true, true);
    $("select[name=kategori]").append(option).trigger("change");
  }
  if (NamaPenerbit) {
    var option = new Option(NamaPenerbit, NamaPenerbit, true, true);
    $("select[name=penerbit]").append(option).trigger("change");
  }
  $("#btn_back").click(function (e) {
    e.preventDefault();
    window.location.href = defaultUrl;
  });
  $("#btn_simpanData").click(function (e) {
    e.preventDefault();
    $.confirm({
      title: "Konfirmasi",
      content: "Data yang diinputkan akan disimpan?",
      buttons: {
        Tidak: {
          btnClass: "btn-warning text-white",
          action: function () {},
        },
        Ya: {
          btnClass: "btn-primary",
          action: function () {
            $.ajax({
              type: "POST",
              data: $("#form_buku").serialize() + "&id" + dataId,
              url: defaultUrl + "update",
              beforeSend: function () {
                $(".loading").removeClass("hide");
              },
              success: function (response) {
                $(".loading").addClass("hide");
                if (response.error == 0) {
                  notification("success", "Data Berhasil Disimpan");
                  location.href = defaultUrl;
                } else {
                  notification("danger", "Data Gagal Disimpan");
                }
              },
            });
          },
        },
      },
    });
  });
});

function select2data() {
  $("select[name=penulis]").select2({
    allowClear: true,
    theme: "bootstrap4",
    placeholder: "Pilih Penulis",
    width: "auto",
    ajax: {
      url: "{{ url('panel/referensi/getPenulis') }}",
      data: function (params) {
        return {
          q: params.term,
          page: params.page || 1,
        };
      },
      processResults: function (response) {
        var data = JSON.parse(response);

        return {
          results: data.data.map(function (i) {
            i.id = i.nama;
            i.text = `${i.nama}`;

            return i;
          }),
          pagination: {
            more: data.has_more,
          },
        };
      },
    },
  });
  $("select[name=penerbit]").select2({
    allowClear: true,
    theme: "bootstrap4",
    placeholder: "Pilih Penerbit",
    width: "auto",
    ajax: {
      url: "{{ url('panel/referensi/getPenerbit') }}",
      data: function (params) {
        return {
          q: params.term,
          page: params.page || 1,
        };
      },
      processResults: function (response) {
        var data = JSON.parse(response);

        return {
          results: data.data.map(function (i) {
            i.id = i.nama;
            i.text = `${i.nama}`;

            return i;
          }),
          pagination: {
            more: data.has_more,
          },
        };
      },
    },
  });
  $("select[name=kategori]").select2({
    allowClear: true,
    theme: "bootstrap4",
    placeholder: "Pilih Kategori",
    width: "auto",
    ajax: {
      url: "{{ url('panel/referensi/getKategori') }}",
      data: function (params) {
        return {
          q: params.term,
          page: params.page || 1,
        };
      },
      processResults: function (response) {
        var data = JSON.parse(response);

        return {
          results: data.data.map(function (i) {
            i.id = i.nama;
            i.text = `${i.nama}`;

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

function uploadFile() {
  var file = $("#cover")[0].files[0];

  var postData = new FormData();
  postData.append("filename", file);
  postData.append("old_file", oldFile); // Kirim nama file lama jika ada

  $.ajax({
    url: defaultUrl + "UploadFile",
    cache: false,
    contentType: false,
    processData: false,
    data: postData,
    type: "POST",
    beforeSend: function () {
      $(".loading").removeClass("hide");
    },
    success: function (data) {
      console.log(data);
      oldFile = data.filename;

      $('#form_buku [name="nama_cover"]').val(
        JSON.stringify({
          name: data.name,
          file_name: data.filename,
          jenis: data.jenis,
        })
      );
      $(".loading").addClass("hide");
      if (data.status === 0) {
        notification("danger", data.message);
      } else {
        notification("success", "File Berhasil diupload");
      }
    },
    error: function (data) {
      console.log(data);
      notification("danger", "Error: " + data);
      $(".loading").addClass("hide");
    },
    complete: function () {
      $(".loading").addClass("hide");
    },
  });
}
