window.defaultUrl = `${baseUrl}/transaksi/peminjaman/`;
var i = 0;
$(document).ready(function () {
  select2data();
  viewDatatable();
  $("#searchBtnButton").click(function () {
    $("#datatable-buku").DataTable().ajax.reload();
  });
  $("#searchBuku").keypress(function (e) {
    if (e.which == 13) {
      e.preventDefault();
      $("#datatable-buku").DataTable().ajax.reload();
    }
  });
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
              data: $("#form_buku").serialize(),
              url: defaultUrl + "store",
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
  $("select[name=kategori]").select2({
    allowClear: true,
    theme: "bootstrap4",
    placeholder: "Filter berdasarkan Kategori",
    width: "25%",

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
  $("select[name=id_anggota]").select2({
    allowClear: true,
    theme: "bootstrap4",
    width: "auto",
    ajax: {
      url: "{{ url('panel/referensi/getAnggota') }}",
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
            i.id = i.id;
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

function viewDatatable() {
  table = $("#datatable-buku").DataTable({
    ajax: {
      url: defaultUrl + "datatableBuku",
      type: "post",
      data: function (d) {
        d.searchBuku = $("#searchBuku").val();
      },
    },
    serverSide: true,
    processing: true,
    responsive: true,
    selected: false,
    aaSorting: [],
    columnDefs: [
      {
        searchable: false,
        targets: [0],
      },
    ],
    columns: [
      {
        data: null,
        orderable: false,
        render: function (data, index, row, meta) {
          var value = `
                       <div class="custom-control custom-checkbox">
                        <label>
                            <input type="checkbox" name="id_buku[]" value="${row.id}">
                        </label>
                       </div>
                       `;
          return value;
        },
      },
      {
        data: "id",
        orderable: false,
        render: function (data, index, row, meta) {
          return `
                <div class="text-center">
                  <span>${meta.row + meta.settings._iDisplayStart + 1}</span>
                </div>
          `;
        },
      },
      {
        data: "kode_buku",
        render: function (data, index, row, meta) {
          if (_.isEmpty(data)) {
            return `-`;
          } else {
            return data;
          }
        },
      },
      {
        data: "judul",
        render: function (data, index, row, meta) {
          if (_.isEmpty(data)) {
            return `-`;
          } else {
            return data;
          }
        },
      },
      {
        data: "penulis",
        render: function (data, index, row, meta) {
          if (_.isEmpty(data)) {
            return `-`;
          } else {
            return data;
          }
        },
      },
      {
        data: "penerbit",
        render: function (data, index, row, meta) {
          if (_.isEmpty(data)) {
            return `-`;
          } else {
            return data;
          }
        },
      },
      {
        data: "tahun_terbit",
        render: function (data, index, row, meta) {
          if (_.isEmpty(data)) {
            return `-`;
          } else {
            return data;
          }
        },
      },
      {
        data: "kategori",
        render: function (data, index, row, meta) {
          if (_.isEmpty(data)) {
            return `-`;
          } else {
            return data;
          }
        },
      },
      {
        data: "status",
        render: function (data, index, row, meta) {
          if (_.isEmpty(data)) {
            return `-`;
          } else {
            return `
                <div class="text-center text-capitalize">
                  <span class="badge badge-success p-2">
                    <h6>${data}</h6>
                  </span>
                </div>
            `;
          }
        },
      },
      {
        data: "cover",
        render: function (data, index, row, meta) {
          if (_.isEmpty(data)) {
            return `-`;
          } else {
            return `
                <div class="text-center">
                 <img src="${baseUrl}/cover/${data}" width="50px" />
                </div>
            `;
          }
        },
      },
    ],
  });
}
