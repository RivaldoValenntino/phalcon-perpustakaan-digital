{% extends 'template/dashboard.volt' %} {% block title %} Transaksi - Peminjaman
{% endblock %} {% block inline_style %}
<style>
  .select2-container--bootstrap4 .select2-selection--single {
    height: calc(3em) !important;
    font-size: 1rem;
  }

  .select2-selection--multiple {
    overflow: hidden !important;
    height: auto !important;
  }
  select.error + .select2-container--bootstrap4 .select2-selection--single {
    border-color: #dc3545 !important;
  }
  label.error {
    position: absolute;
    bottom: -1.5em;
    left: 0;
    font-size: 0.875em;
    color: #dc3545;
  }

  .form-group {
    margin-bottom: 2.5rem;
  }
  input[type="number"]::-webkit-inner-spin-button,
  input[type="number"]::-webkit-outer-spin-button {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    margin: 0;
  }
</style>
{% endblock %} {% block content %}

<div class="page-content container">
  <div class="card ccard">
    <div
      class="card-header pb-1 align-middle border-t-3 brc-primary-tp3"
      style="
        border-top-left-radius: 0.4rem;
        border-top-right-radius: 0.4rem;
        border-bottom: 1px solid #e0e5e8 !important;
      "
    >
      <h4 class="py-2">Transaksi - Peminjaman</h4>
      <a
        style="text-wrap: nowrap"
        class="btn btn-lg btn-primary ml-4 mb-2"
        href="{{ url('panel/transaksi/peminjaman') }}"
      >
        <i class="fa fa-arrow-left"></i>
        Kembali
      </a>
    </div>
    <form id="form_buku">
      <div class="card-body">
        <div class="d-flex justify-content-center align-items-center">
          <img id="output" class="img-fluid mx-auto" width="200" />
        </div>
        <div class="col-lg-12 p-5">
          <div class="row">
            <div class="col-lg-6 card p-0 mx-auto mb-5">
              <div class="card-header bgc-blue-d2 text-white">
                <h4 class="py-2">Data Peminjaman</h4>
              </div>
              <div class="col-lg-12 card-body">
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span
                      class="input-group-text"
                      id="inputGroup-sizing-default"
                      >Tanggal Pinjam
                    </span>
                  </div>
                  <input
                    type="text"
                    class="form-control datepicker"
                    name="tanggal_pinjam"
                    id="tanggal_pinjam"
                    autocomplete="off"
                    aria-label="Sizing example input"
                    aria-describedby="inputGroup-sizing-default"
                  />
                </div>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span
                      class="input-group-text"
                      id="inputGroup-sizing-default"
                      >Tanggal Kembali
                    </span>
                  </div>
                  <input
                    type="text"
                    name="tanggal_kembali"
                    id="tanggal_kembali"
                    class="form-control datepicker"
                  />
                </div>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span
                      class="input-group-text"
                      id="inputGroup-sizing-default"
                      >Anggota
                    </span>
                  </div>
                  <select
                    name="id_anggota"
                    id="id_anggota"
                    class="form-control select2"
                  ></select>
                </div>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span
                      class="input-group-text"
                      id="inputGroup-sizing-default"
                      >Keterangan
                    </span>
                  </div>
                  <textarea
                    cols="20"
                    rows="3"
                    placeholder="(Opsional)"
                    name="keterangan"
                    id="keterangan"
                    class="form-control"
                  ></textarea>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-lg-12">
              <div class="card dcard">
                <div class="card-header bgc-blue-d2">
                  <h5 class="card-title text-120" style="color: #ffffff">
                    Data Buku
                  </h5>
                </div>
                <div class="card-body p-0">
                  <form id="form-pencarian-buku" class="mt-2">
                    <div class="form-group pt-3">
                      <div class="col-sm-12">
                        <div class="input-group">
                          <div class="input-group-prepend">
                            <span class="input-group-text">Cari Buku</span>
                          </div>
                          <input
                            type="text"
                            id="searchBuku"
                            name="searchBuku"
                            class="form-control"
                            required
                            placeholder="Cari Buku berdasarkan judul atau kode"
                          />
                          <div class="input-group-append">
                            <button
                              type="button"
                              class="btn btn-primary"
                              id="searchBtnButton"
                            >
                              <i class="fas fa-search"></i>
                              Cari
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </form>
                  <hr />
                  <div id="dataBuku" class="ml-4 mr-4">
                    <table
                      id="datatable-buku"
                      class="action-arrow d-style w-100 table table-striped table-bordered table-hover"
                      tabindex="-1"
                    >
                      <thead
                        class="sticky-nav text-secondary-m1 text-uppercase text-85"
                      >
                        <tr class="text-center">
                          <th>
                            <input type="checkbox" id="check_all" />
                          </th>
                          <th>#</th>
                          <th>Kode</th>
                          <th>Judul</th>
                          <th>Penulis</th>
                          <th>Penerbit</th>
                          <th>Tahun Terbit</th>
                          <th>Kategori</th>
                          <th>Status</th>
                          <th>Cover</th>
                        </tr>
                      </thead>
                      <tbody class="pos-rel"></tbody>
                    </table>
                  </div>
                </div>
                <!-- /.card-body -->
              </div>
            </div>
          </div>
          <div class="col-lg-12">
            <div class="py-5" style="float: right !important">
              <button
                type="button"
                class="btn btn-success px-5 py-25 text-125 mb-1"
                id="btn_simpanData"
              >
                <i class="fas fa-save mr-2"></i>
                Simpan
              </button>
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
{% endblock %} {% block inline_script %}
<script
  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA1tykeokAuk0hMmArIq2wmFj4jy6uen_o&libraries=places,drawing,geometry"
  type="text/javascript"
></script>
<script>
  {% include 'Defaults/Peminjaman/create.js' %}
</script>
{% endblock %}
