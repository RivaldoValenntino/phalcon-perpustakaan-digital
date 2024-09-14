{% extends 'template/dashboard.volt' %} {% block title %} Mutasi Aset - Tambah
{% endblock %} {% block inline_style %}
<style>
  .select2-container--bootstrap4 .select2-selection--single {
    height: calc(3em) !important;
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
      <h4 class="py-2">Edit Data Buku - {{ dataBuku["judul"] }}</h4>
      <a
        style="text-wrap: nowrap"
        class="btn btn-lg btn-primary ml-4 mb-2"
        href="{{ url('panel/master/data-buku') }}"
      >
        <i class="fa fa-arrow-left"></i>
        Kembali
      </a>
    </div>
    <form id="form_buku">
      <div class="card-body">
        <div class="d-flex justify-content-center align-items-center">
          <img
            id="output"
            class="img-fluid mx-auto"
            width="200"
            src="{{ url() }}{{ coverImageUrl }}"
          />
        </div>
        <div class="col-lg-12 p-3">
          <div class="row">
            <div class="col-lg-6">
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" id="inputGroup-sizing-default"
                    >Judul Buku
                  </span>
                </div>
                <input
                  type="text"
                  class="form-control"
                  name="judul"
                  id="judul"
                  value="{{ dataBuku['judul'] }}"
                  placeholder="Judul Buku"
                  autocomplete="off"
                  aria-label="Sizing example input"
                  aria-describedby="inputGroup-sizing-default"
                />
              </div>
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" id="inputGroup-sizing-default"
                    >Penulis
                  </span>
                </div>
                <select
                  name="penulis"
                  id="penulis"
                  class="form-control select2"
                ></select>
              </div>
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" id="inputGroup-sizing-default"
                    >Penerbit
                  </span>
                </div>
                <select
                  name="penerbit"
                  id="penerbit"
                  class="form-control select2"
                ></select>
              </div>
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" id="inputGroup-sizing-default"
                    >Kategori
                  </span>
                </div>
                <select
                  name="kategori"
                  id="kategori"
                  class="form-control select2"
                ></select>
              </div>
            </div>
            <div class="col-lg-6" style="margin-top: 90px">
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" id="inputGroup-sizing-default"
                    >Tahun Terbit
                  </span>
                </div>
                <input
                  type="text"
                  class="form-control yearpicker"
                  name="tahun_terbit"
                  id="tahun_terbit"
                  value="{{ dataBuku['tahun_terbit'] }}"
                  placeholder="Tahun Terbit"
                  autocomplete="off"
                  aria-label="Sizing example input"
                  aria-describedby="inputGroup-sizing-default"
                />
              </div>
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" id="inputGroup-sizing-default"
                    >Cover
                  </span>
                </div>
                <input
                  type="file"
                  class="form-control"
                  onchange="document.getElementById('output').src = window.URL.createObjectURL(this.files[0])"
                  name="cover"
                  id="cover"
                  aria-label="Sizing example input"
                  aria-describedby="inputGroup-sizing-default"
                />
                <input
                  type="hidden"
                  id="nama_cover"
                  name="nama_cover"
                  class="form-control"
                />
              </div>
            </div>
            <div class="col-lg-12" style="padding-inline-start: 14px">
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text" id="inputGroup-sizing-default"
                    >Keterangan
                  </span>
                </div>
                <textarea
                  cols="20"
                  name="keterangan"
                  rows="3"
                  name="keterangan"
                  id="keterangan"
                  class="form-control"
                ></textarea>
              </div>
            </div>
            <div class="col-lg-12">
              <div class="mt-2 mb-2 mr-2" style="float: right !important">
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
  {% include 'Defaults/Master/Buku/edit.js' %}
</script>
{% endblock %}
