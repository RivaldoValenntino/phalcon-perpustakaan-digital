{% extends 'template/dashboard.volt' %} {% block title %}Daftar Anggota {%
endblock %} {% block content %}
<style>
  .select2-container--bootstrap4 .select2-selection--single {
    height: calc(3em) !important;
  }
  /* Chrome, Safari, Edge, Opera */
  input::-webkit-outer-spin-button,
  input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
  }

  /* Firefox */
  input[type="number"] {
    -moz-appearance: textfield;
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
      <h4 class="card-title text-dark-m3 mt-2">Data Anggota</h4>
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
                <tr class="bgc-info text-white text-center brc-black-tp10">
                  <th style="vertical-align: middle">#</th>
                  <th style="vertical-align: middle">Nama</th>
                  <th style="vertical-align: middle">Telepon</th>
                  <th style="vertical-align: middle">Email</th>
                  <th style="vertical-align: middle">Alamat</th>
                </tr>
              </thead>
              <tbody></tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal Form -->
<div
  id="formModal"
  class="modal fade"
  tabindex="-1"
  role="dialog"
  aria-labelledby="formModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog radius-4">
    <!-- Modal content-->
    <div class="modal-content radius-4">
      <div class="modal-header bgc-primary radius-t-4">
        <h4 class="modal-title text-white">
          <i class="fa fa-list text-white"></i>&nbsp;&nbsp; Form - Anggota
        </h4>
        <button type="button" class="close text-white" data-dismiss="modal">
          &times;
        </button>
      </div>
      <form class="form-horizontal" action="javascript:;">
        <div class="modal-body">
          <input type="hidden" name="_type" value="create" />
          <input type="hidden" name="id" value="" />

          <div class="row form-group">
            <div class="col-sm-12" style="margin-bottom: 5px">
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" style="width: 150px"
                    >Nama</span
                  >
                </div>
                <input
                  type="text"
                  id="nama"
                  name="nama"
                  class="form-control"
                  required
                />
              </div>
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" style="width: 150px"
                    >Telepon</span
                  >
                </div>
                <input
                  type="number"
                  id="telepon"
                  name="telepon"
                  class="form-control"
                  required
                />
              </div>
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" style="width: 150px"
                    >Alamat</span
                  >
                </div>
                <textarea
                  name="alamat"
                  id="alamat"
                  class="form-control"
                  rows="3"
                  cols="30"
                  style="resize: none"
                ></textarea>
              </div>
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" style="width: 150px"
                    >Email</span
                  >
                </div>
                <input
                  type="email"
                  id="email"
                  name="email"
                  class="form-control"
                  required
                />
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer radius-b-4">
          <button
            type="button"
            class="btn btn-danger px-4 radius-2"
            data-dismiss="modal"
          >
            <i class="fas fa-times"></i>
            Tutup
          </button>
          <button type="submit" class="btn btn-success radius-2">
            <i class="fas fa-save"></i>
            Simpan
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Modal Search -->
<div id="filterModal" class="modal fade" role="dialog">
  <div class="modal-dialog radius-4">
    <!-- Modal content-->
    <div class="modal-content radius-4">
      <div class="modal-header bgc-primary radius-t-4">
        <h4 class="modal-title text-white">
          <i class="fa fa-search text-white"></i>&nbsp;&nbsp; Pencarian -
          Anggota
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
              <span class="input-group-text"> Nama </span>
            </div>
            <input
              type="text"
              name="search_nama"
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
              <span class="input-group-text"> Telepon </span>
            </div>
            <input
              type="number"
              name="search_telepon"
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
              <span class="input-group-text"> Alamat </span>
            </div>
            <textarea
              name="search_alamat"
              class="form-control"
              rows="3"
              cols="30"
              style="resize: none"
              disabled=""
            ></textarea>
          </div>
          <div class="input-group mb-2 input-filter">
            <div class="input-group-prepend" style="width: 10% !important">
              <span class="input-group-text">
                <input type="checkbox" class="ace-switch" />
              </span>
            </div>
            <div class="input-group-prepend">
              <span class="input-group-text"> Email </span>
            </div>
            <input
              type="email"
              name="search_email"
              class="form-control"
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
  {% include 'Defaults/Anggota/index.js' %}
</script>
{% endblock %}
