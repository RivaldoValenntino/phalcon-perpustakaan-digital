{% extends 'template/dashboard.volt' %} {% block title %} Master Buku {%
endblock %} {% block content %}
<style>
  .select2-container--bootstrap4 .select2-selection--single {
    height: calc(3em) !important;
  }
</style>
<div class="page-content">
  <div class="card ccard mx-auto" style="width: 98%; position: sticky">
    <div
      class="card-header pb-1 align-middle border-t-3 brc-primary-tp3"
      style="
        border-top-left-radius: 0.4rem;
        border-top-right-radius: 0.4rem;
        border-bottom: 1px solid #e0e5e8 !important;
      "
    >
      <h4 class="card-title text-dark-m3 mt-2">Master - Data Buku</h4>
      <div class="page-tools mt-3 mt-sm-0 mb-sm-n1 card-toolbar">
        <button
          class="btn mr-1 btn-info mb-2 radius-2"
          data-toggle="modal"
          style="float: right"
          id="btn-search"
        >
          <i class="fa fa-search text-110 align-text-bottom mr-2"></i>
          Pencarian
        </button>

        <a
          href="#"
          class="btn mr-1 btn-success mb-2 radius-2"
          id="btn-refresh-data"
        >
          <i class="fa fa-sync text-110 align-text-bottom mr-2"></i>
          Perbarui
        </a>
        <a href="#" class="btn mr-1 btn-primary mb-2 radius-2" id="btn-add">
          <i class="fa fa-plus text-110 align-text-bottom mr-2"></i>
          Tambah
        </a>

        <a href="#" class="btn mr-1 btn-warning mb-2 radius-2" id="btn-edit">
          <i class="fa fa-pencil-alt text-140 align-text-bottom mr-2"></i>
          Edit
        </a>
        <a href="#" class="btn mr-1 btn-danger mb-2 radius-2" id="btn-delete">
          <i class="fa fa-trash-alt text-140 align-text-bottom mr-2"></i>
          Hapus
        </a>
      </div>
    </div>

    <div class="card-body p-3">
      <div class="row">
        <div class="col-md-12">
          <div class="table-responsive-md">
            <table
              id="datatable"
              class="table table-bordered border-0 w-100 table-striped-secondary text-dark-m1 mb-0"
            >
              <thead>
                <tr class="bgc-info text-white text-left brc-black-tp10">
                  <th style="vertical-align: left">#</th>
                  <th style="vertical-align: left">Judul</th>
                  <th style="vertical-align: left">Kode</th>
                  <th style="vertical-align: left">Penulis</th>
                  <th style="vertical-align: left">Penerbit</th>
                  <th style="vertical-align: left">Tahun Terbit</th>
                  <th style="vertical-align: left">Kategori</th>
                  <th style="vertical-align: left">Status</th>
                  <th style="vertical-align: left">Keterangan</th>
                  <th style="vertical-align: left">Cover</th>
                </tr>
              </thead>
              <tbody style="vertical-align: middle"></tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal Form -->

<!-- Modal Search -->
<div id="filterModal" class="modal fade" role="dialog">
  <div class="modal-dialog radius-4">
    <!-- Modal content-->
    <div class="modal-content radius-4">
      <div class="modal-header bgc-primary radius-t-4">
        <h4 class="modal-title text-white">
          <i class="fa fa-search text-white"></i>&nbsp;&nbsp; Pencarian - Master
          Buku
        </h4>
        <button type="button" class="close text-white" data-dismiss="modal">
          &times;
        </button>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" id="form-filter">
          <div class="input-group mb-2 input-filter">
            <div class="input-group-prepend" style="width: 10% !important">
              <span class="input-group-text">
                <input type="checkbox" class="ace-switch" />
              </span>
            </div>
            <div class="input-group-prepend">
              <span class="input-group-text"> Judul </span>
            </div>
            <input
              type="text"
              name="search_judul"
              class="form-control"
              disabled=""
            />
          </div>
          <div class="input-group mb-2 input-filter">
            <div class="input-group-prepend" style="width: 10% !important">
              <span class="input-group-text">
                <input type="checkbox" class="ace-switch" />
              </span>
            </div>
            <div class="input-group-prepend">
              <span class="input-group-text"> Penulis </span>
            </div>
            <select
              type="text"
              name="search_penulis"
              class="form-control"
              disabled=""
            ></select>
          </div>
          <div class="input-group mb-2 input-filter">
            <div class="input-group-prepend" style="width: 10% !important">
              <span class="input-group-text">
                <input type="checkbox" class="ace-switch" />
              </span>
            </div>
            <div class="input-group-prepend">
              <span class="input-group-text"> Penerbit </span>
            </div>
            <select
              type="text"
              name="search_penerbit"
              class="form-control"
              disabled=""
            ></select>
          </div>
          <div class="input-group mb-2 input-filter">
            <div class="input-group-prepend" style="width: 10% !important">
              <span class="input-group-text">
                <input type="checkbox" class="ace-switch" />
              </span>
            </div>
            <div class="input-group-prepend">
              <span class="input-group-text"> Kategori </span>
            </div>
            <select
              type="text"
              name="search_kategori"
              class="form-control"
              disabled=""
            ></select>
          </div>
          <div class="input-group mb-2 input-filter">
            <div class="input-group-prepend" style="width: 10% !important">
              <span class="input-group-text">
                <input type="checkbox" class="ace-switch" />
              </span>
            </div>
            <div class="input-group-prepend">
              <span class="input-group-text"> Tahun Terbit </span>
            </div>
            <input
              type="text"
              name="search_tahun"
              class="form-control yearpicker"
              disabled=""
            />
          </div>
        </form>
      </div>
      <div class="modal-footer radius-b-4">
        <button
          type="button"
          class="btn btn-default submit-filter text-120 radius-2"
          data-dismiss="modal"
        >
          Cari Data
        </button>
      </div>
    </div>
  </div>
</div>
{% endblock %} {% block inline_script %}
<script>
  {% include 'Defaults/Master/Buku/index.js' %}
</script>
{% endblock %}
