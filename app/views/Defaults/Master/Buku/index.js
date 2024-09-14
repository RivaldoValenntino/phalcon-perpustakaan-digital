window.defaultUrl = `${baseUrl}/master/data-buku/`;
var table;

$(document).ready(function () {
  viewDatatable();
  select2data();
  $("#btn-edit").addClass("disabled");
  $("#btn-delete").addClass("disabled");
  $("#btn-refresh-data").click(function () {
    $("#filterModal").find("input[type=checkbox]").prop("checked", false);
    $("input[name=search_judul]").val("");
    $("input[name=search_judul]").prop("disabled", true);
    $("input[name=search_tahun]").val("");
    $("input[name=search_tahun]").prop("disabled", true);
    $("select[name=search_penerbit]").val(null);
    $("select[name=search_penerbit]").prop("disabled", true);
    $("select[name=search_penulis]").val(null);
    $("select[name=search_penulis]").prop("disabled", true);
    $("select[name=search_kategori]").val(null);
    $("select[name=search_kategori]").prop("disabled", true);
    table.ajax.reload();
  });

  $("#btn-search").click(function () {
    $("#filterModal").modal("show");
  });

  $("#btn-add").click(function () {
    window.location.href = defaultUrl + "create";
  });

  $("#btn-edit").click(function (e) {
    e.preventDefault();
    let selected = table
      .row({
        selected: true,
      })
      .data();
    if (_.isEmpty(selected)) {
      notification("warning", "Pilih Data Terlebih Dahulu");
      return false;
    }
    if (selected) {
      if (selected.id == null) {
        return notification("warning", "Data Tidak Ditemukan");
      }
      window.location.href = defaultUrl + "edit/" + selected.id;
    }
  });

  $("#btn-delete").on("click", async function () {
    let selected = table
      .row({
        selected: true,
      })
      .data();
    if (_.isEmpty(selected)) {
      notification("warning", "Pilih Data Terlebih Dahulu");
      return false;
    }
    if (selected && (await confirmDelete()).value) {
      $.post(defaultUrl + "delete?id=" + selected.id)
        .done(function () {
          notification("success", "Data berhasil dihapus");
          table.ajax.reload();
          $("#btn-edit").addClass("disabled");
          $("#btn-delete").addClass("disabled");
        })
        .fail(function () {
          notification("danger", "Data gagal dihapus");
        });
    }
  });
});

function viewDatatable() {
  table = $("#datatable")
    .DataTable({
      ajax: {
        url: defaultUrl + "datatable",
        type: "post",
        data: function (d) {
          var formData = $("#form-filter").serializeArray();
          $.each(formData, function (key, val) {
            d[val.name] = val.value;
          });
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
          data: "id",
          orderable: false,
          render: function (data, index, row, meta) {
            return meta.row + meta.settings._iDisplayStart + 1 + ".";
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
                    <div class="text-center text-140 text-capitalize">
                        <span class="badge badge-${
                          data == "tersedia" ? "success" : "danger"
                        }">${data}</span>
                    </div>
              `;
            }
          },
        },
        {
          data: "keterangan",
          render: function (data, index, row, meta) {
            if (_.isEmpty(data)) {
              return `-`;
            } else {
              return data;
            }
          },
        },
        {
          data: "cover",
          render: function (data, index, row, meta) {
            if (_.isEmpty(data)) {
              return `-`;
            } else {
              return `<img src="${baseUrl}/cover/${data}" width="50px">`;
            }
          },
        },
      ],
      createdRow: function (row, data, index) {
        $(row).attr("data-value", encodeURIComponent(JSON.stringify(data)));
        $("thead").css({ "vertical-align": "middle", "text-align": "center" });
        $("td", row).css({
          "vertical-align": "middle",
          padding: "0.5em",
          cursor: "pointer",
        });
        $("td", row).first().css({ width: "3%", "text-align": "center" });
        //Default
        $("td", row)
          .eq(1)
          .css({ "text-align": "left", "font-weight": "normal" });
      },
    })
    .on("click", "tr", function () {
      if ($(this).hasClass("selected")) {
        $("#btn-edit").removeClass("disabled");
        $("#btn-delete").removeClass("disabled");
      } else {
        $("#btn-edit").addClass("disabled");
        $("#btn-delete").addClass("disabled");
      }
    });
}

function resetErrors() {
  $(".form-control").each(function (i, el) {
    $(el).removeClass("brc-danger-m2");
    $(el).next().text("").hide();
    $(el).prev().removeClass("text-danger-d1");
  });
}

function confirmDelete() {
  let swalWithBootstrapButtons = Swal.mixin({
    buttonsStyling: false,
  });

  return swalWithBootstrapButtons.fire({
    title: "Apakah anda yakin?",
    type: "warning",
    showCancelButton: true,
    scrollbarPadding: false,
    confirmButtonText: "Ya",
    cancelButtonText: "Tidak",
    customClass: {
      confirmButton: "btn btn-success mx-2 px-3 radius-2",
      cancelButton: "btn btn-danger mx-2 px-3 radius-2",
    },
  });
}

function select2data() {
  $("select[name=search_penulis]").select2({
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
  $("select[name=search_penerbit]").select2({
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
  $("select[name=search_kategori]").select2({
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
