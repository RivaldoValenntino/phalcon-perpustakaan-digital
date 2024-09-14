<!doctype html>
<html lang="en" style="--scrollbar-width:16px; --moz-scrollbar-thin:16px; font-size: 0.7rem;">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1">

  <title>{% block title %}{% endblock %} - {{ config.appName }}</title>

  <!-- include common vendor stylesheets & fontawesome -->
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/bootstrap/dist/css/bootstrap.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/bootstrap-select/dist/css/bootstrap-select.css">
  <link rel="stylesheet" href="{{ url('assets') }}/css/src/colorbox/colorbox.min.css">

  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/@fortawesome/fontawesome-free/css/fontawesome.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/@fortawesome/fontawesome-free/css/regular.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/@fortawesome/fontawesome-free/css/brands.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/@fortawesome/fontawesome-free/css/solid.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/smartwizard/dist/css/smart_wizard.min.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/smartwizard/dist/css/smart_wizard_theme_circles.min.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/jqtree/jqtree.css">

  {% block styles %}
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/datatables.net-bs4/css/dataTables.bootstrap4.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/datatables.net-buttons-bs4/css/buttons.bootstrap4.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.standalone.min.css" integrity="sha512-TQQ3J4WkE/rwojNFo6OJdyu6G8Xe9z8rMrlF9y7xpFbQfW5g8aSWcygCQ4vqRiJqFsDsE1T6MoAOMJkFXlrI9A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
  {% endblock %}

  <!-- include fonts -->
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/dist/css/ace-font.css">

  <!-- ace.css -->
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/dist/css/ace.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/dist/css/project.css">
  <!-- select2.css -->
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/select2/dist/css/select2.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@ttskch/select2-bootstrap4-theme@x.x.x/dist/select2-bootstrap4.min.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/css/src/bootstrap-datepicker3.min.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/css/src/bootstrap-datetimepicker.min.css">
  <link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/chosen-js/chosen.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/js/src/pagination/paging.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/daterangepicker/daterangepicker.css">

  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/photoswipe/dist/photoswipe.css">
  <link rel="stylesheet" type="text/css" href="{{ url('assets') }}/node_modules/photoswipe/dist/default-skin/default-skin.css">

  <!-- favicon -->
  <link rel="icon" type="image/png" href="{{ url('assets') }}/image/fav.png" />
  <style>
    .input-group-text{
      font-size: 1.2rem !important;
    }
    .form-control{
      font-size: 1.2rem !important;
    }
  </style>
  <!-- "Login" page styles, specific to this page for demo only -->
  {% block inline_style %}
  {% endblock %}
</head>

<body>
  <div class="loading hide">Loading&#8230;</div>
  <div class="sidebar d-none">
    <nav class="sidebar-nav">
  </div>
  <div class="body-container">
    <!-- Navbar -->
    <nav class="navbar navbar-sm navbar-expand-lg navbar-fixed navbar-blue">
      <div class="navbar-inner brc-grey-l2 shadow-md">

        <!-- this button collapses/expands sidebar in desktop mode -->
        <button type="button" class="btn btn-burger align-self-center d-none d-xl-flex mx-2 px-0" data-toggle="sidebar" data-target="#sidebar" aria-controls="sidebar" aria-expanded="true" aria-label="Toggle sidebar">
          <span class="bars"></span>
        </button>

        <div class="d-flex h-100 align-items-center justify-content-xl-between">
          <!-- this button shows/hides sidebar in mobile mode -->
          <button type="button" class="btn btn-burger static burger-arrowed collapsed d-flex d-xl-none ml-2 bgc-h-white-l31" data-toggle-mobile="sidebar" data-target="#sidebar" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle sidebar">
            <span class="bars text-white"></span>
          </button>

          <a class="navbar-brand ml-2 text-white" href="#">
            <!-- {{ config.appName }} {{ session.tahun }} -->
            {{ config.appName }}
          </a>
        </div>


        <!-- .navbar-menu toggler -->
        <button class="navbar-toggler mx-1 p-25" type="button" data-toggle="collapse" data-target="#navbarMenu" aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navbar menu">
          <i class="fa fa-user text-white"></i>
        </button>


        <div class="ml-auto mr-lg-2 navbar-menu collapse navbar-collapse navbar-backdrop" id="navbarMenu">
          <div class="navbar-nav">
            <ul class="nav nav-compact-2">
              <!-- <li class="nav-item">
                <a class="nav-link dropdown-toggle mr-1px" href="{{ url('auth/logout') }}">
                  <i class="fa fa-sign-out-alt mr-1"></i>
                  Sign Out
                </a>
              </li> -->
              <li class="nav-item user user-menu">
                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                <i class="fa fa-user"></i>&nbsp;
                  <span class="nav-user-name">{{ session.user['nama'] }}</span>
        
                  <i class="caret fa fa-angle-down d-none d-xl-block"></i>
                  <i class="caret fa fa-angle-left d-block d-lg-none"></i>
                </a>
        
                <div class="dropdown-menu dropdown-caret dropdown-menu-right dropdown-animated brc-primary-m3 py-1">
                  
                  {% if session.user['id_role'] == 1 %}
                  
                  <a class="dropdown-item btn btn-outline-grey bgc-h-success-l3 btn-h-light-success btn-a-light-success" href="{{ url('/panel/log-akses') }}">
                    <i class="fa fa-map-signs text-success-m1 text-105 mr-1"></i>
                    Log Akses
                    </a>
                  <!-- <a class="dropdown-item btn btn-outline-grey bgc-h-success-l3 btn-h-light-success btn-a-light-success" href="{{ url('Log') }}">
                    <i class="fa fa-cog text-success-m1 text-105 mr-1"></i>
                    Log Sistem
                  </a> -->

                  <div class="dropdown-divider brc-primary-l2"></div>
                  {% endif %}
                  <a class="dropdown-item btn btn-outline-grey bgc-h-success-l3 btn-h-light-success btn-a-light-success" href="{{ url('Gantipassword') }}">
                    <i class="fa fa-key text-success-m1 text-105 mr-1"></i>
                    Ganti Password
                  </a>

                  {% if session.is_using == 'PDAM-BALI' %}
                    <a class="dropdown-item btn btn-outline-grey bgc-h-secondary-l3 btn-h-light-secondary btn-a-light-secondary" href="{{ url('/panel/auth/logoutToPortal') }}">
                      <i class="fa fa-power-off text-warning-d1 text-105 mr-1"></i>
                      Kembali Ke Portal
                    </a>                    
                  {% else %}
                    <a class="dropdown-item btn btn-outline-grey bgc-h-secondary-l3 btn-h-light-secondary btn-a-light-secondary" href="{{ url('/panel/auth/logout') }}">
                      <i class="fa fa-power-off text-warning-d1 text-105 mr-1"></i>
                      Logout
                    </a>
                  {% endif %}
                  
                </div>
                </li>
            </ul>
          </div>
        </div><!-- .navbar-menu -->


      </div><!-- .navbar-inner -->
    </nav>
    <div class="main-container bgc-white">

      <!-- Sidebar -->
      <div id="sidebar" class="sidebar sidebar-fixed expandable sidebar-light collapsed" data-backdrop="true" data-dismiss="true" data-swipe="true">
        <div class="sidebar-inner">

          <div class="ace-scroll flex-grow-1 mt-1px" data-ace-scroll="{}">
            {% block navigation %}
            {% include 'template/navigation-dynamic.volt' %}
            {% endblock %}
          </div><!-- /.ace-scroll -->

        </div>
      </div>


      <!-- Main Content -->
      <div class="main-content">
        {% block content %}
        <!-- Page Content -->
        <div class="page-content">
          <div class="card acard">
            <div class="card-body">
              Basic empty page
            </div>
          </div>
        </div>
        {% endblock %}
      </div>

    </div>

  </div>

  <!-- include common vendor scripts used in demo pages -->
  <script src="{{ url('assets') }}/node_modules/jquery/dist/jquery.js"></script>
  
  <script src="{{ url('assets') }}/js/src/vendor.js"></script>
  {% block scripts %}
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.2/pdfmake.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.2/vfs_fonts.min.js" integrity="sha512-BDZ+kFMtxV2ljEa7OWUu0wuay/PAsJ2yeRsBegaSgdUhqIno33xmD9v3m+a2M3Bdn5xbtJtsJ9sSULmNBjCgYw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.7.1/jszip.min.js"></script>
  <script src="{{ url('assets') }}/node_modules/datatables/media/js/jquery.dataTables.js"></script>
  <script src="{{ url('assets') }}/node_modules/datatables.net-bs4/js/dataTables.bootstrap4.js"></script>
  <script src="{{ url('assets') }}/node_modules/datatables.net-colreorder/js/dataTables.colReorder.js"></script>
  <script src="{{ url('assets') }}/node_modules/datatables.net-select/js/dataTables.select.js"></script>
  <script src="{{ url('assets') }}/node_modules/datatables.net-buttons/js/dataTables.buttons.js"></script>
  <script src="{{ url('assets') }}/node_modules/datatables.net-buttons-bs4/js/buttons.bootstrap4.js"></script>
  <script src="{{ url('assets') }}/node_modules/datatables.net-buttons/js/buttons-html7.js"></script>
	<script src="{{ url('assets') }}/node_modules/datatables.net-buttons/js/buttons.print.js"></script>
	<script src="{{ url('assets') }}/node_modules/datatables.net-buttons/js/buttons.colVis.js"></script>
  <script src="{{ url('assets') }}/node_modules/jquery-validation/dist/jquery.validate.js"></script>
  <script src="{{ url('assets') }}/node_modules/inputmask/dist/jquery.inputmask.js"></script>
  <script src="{{ url('assets') }}/node_modules/bootstrap-select/dist/js/bootstrap-select.js"></script>
  <script src="{{ url('assets') }}/node_modules/select2/dist/js/select2.min.js"></script>
  <script src="{{ url('assets') }}/js/src/jquery.maskedinput.min.js"></script>
  <script src="{{ url('assets') }}/node_modules/jqtree/tree.jquery.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.js"></script>
  <!-- <script src="https://handsontable.com/docs/7.1.0/components/numbro/dist/languages.min.js"></script> -->
  <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
  <script src="https://cdn.datatables.net/plug-ins/1.11.3/api/sum().js"></script>
  <script src="https://cdn.datatables.net/plug-ins/1.11.3/api/average().js"></script>
  <script src="https://cdn.jsdelivr.net/npm/numbro@2.3.1/dist/numbro.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/numbro@2.3.1/dist/languages.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/numbro@2.3.1/dist/languages/id.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/collect.js/4.18.3/collect.min.js" integrity="sha512-LkKpealLJ+RNIuYaXSC+l/0Zf5KjYCpMaUrON9WUC+LG316w3UEImyaUpWMWfqNGC4vLOkxDWEVKQE+Wp0shKg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  {% endblock %}
  
  <!-- include ace.js -->
  <script src="{{ url('assets') }}/dist/js/ace.js"></script>
  <script src="{{ url('assets') }}/js/src/moment.js"></script>
  <script src="{{ url('assets') }}/js/src/project.js"></script>
  <script src="{{ url('assets') }}/js/src/helper.js"></script>
  <script src="{{ url('assets') }}/js/src/app.js"></script>
  <script src="{{ url('assets') }}/node_modules/popper.js/dist/umd/popper.js"></script>
  <script src="{{ url('assets') }}/node_modules/bootstrap/dist/js/bootstrap.js"></script>
  <script src="{{ url('assets') }}/js/src/bootstrap-datepicker.js"></script>
  <script src="{{ url('assets') }}/js/src/bootstrap-datetimepicker.min.js"></script>
  <script src="{{ url('assets') }}/js/src/shortcut.js"></script>
  <script src="{{ url('assets') }}/js/src/jquery.price_format.min.js"></script>
  <script src="{{ url('assets') }}/js/src/JQlipboard.js"></script>
  <script src="{{ url('assets') }}/node_modules/chosen-js/chosen.jquery.js"></script>
  <script src="{{ url('assets') }}/node_modules/bootstrap-tagsinput/dist/bootstrap-tagsinput.js"></script>

  <script src="{{ url('assets') }}/node_modules/smartwizard/dist/js/jquery.smartWizard.js"></script>
  {# <script src="{{ url('assets') }}/js/src/fileinput.js"></script> #}
  {# <script src="{{ url('assets') }}/js/src/util.js"></script> #}
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.3.5/dist/sweetalert2.all.min.js" integrity="sha256-rFie6glbD6Zy9CLbJuxIEyU/VRe34QOSc1QH4eXrDQk=" crossorigin="anonymous"></script>
  <script src="{{ url('assets') }}/js/src/pagination/pagination.min.js"></script>
  <script src="{{ url('assets') }}/js/src/pagination/paging.min.js"></script>
  <script src="{{ url('assets') }}/daterangepicker/daterangepicker.js"></script>
  <script src="{{ url() }}/ckeditor/ckeditor.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/easy-pie-chart/2.1.6/jquery.easypiechart.min.js" integrity="sha512-DHNepbIus9t4e6YoMBSJLwl+nnm0tIwMBonsQQ+W9NKN6gVVVbomJs9Ii3mQ+HzGZiU5FyJLdnAz9a63ZgZvTQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/easy-pie-chart/2.1.6/easypiechart.min.js" integrity="sha512-1yldf7W5suy0ko2u4OGU1qyeGrzh9+A3uyWGH4ws8MbndaWxZsgnzy6uqqBq7NUU/ImI1Js5kqDbunovCN1JqA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="{{ url('assets') }}/js/src/jquery.autocomplete.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.touchswipe/1.6.19/jquery.touchSwipe.js" integrity="sha512-gRg3MTbqGUwZiqkDRUj7BJOqiYX6tQDAkZVq6zCHfRUxBhoW0kRG4ASllaK31PIe+I+xdaJhLcZXbs2O2r8SRg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script>
    window.baseUrl = "{{ url() }}";
    $('.dropdown-toggle').dropdown();
    $('.date-picker').datepicker({
      format: "dd-mm-yyyy",
      autoclose: true,
      todayHighlight: true
    }).on('input change select', function (e) {
      $(this).valid();
    });;

    $('.date-picker-sql').datepicker({
      format: "yyyy-mm-dd",
      autoclose: true,
      todayHighlight: true
    }).on('input change select', function (e) {
      $(this).valid();
    });;

    $(".yearpicker").datepicker({
      format: "yyyy",
      minViewMode: 'years', // or 1, 月选择
      startView: 'decade', // or 2, 10年选择
      autoclose: true,
    }).on('input change select', function (e) {
      $(this).valid();
    });;

    $('.date-picker-now').datepicker({
        setDate: new Date(),
        format: "dd-mm-yyyy",
        autoclose: true,
        todayHighlight: true
    }).on('input change select', function (e) {
      $(this).valid();
    });;
    
    $('.yearmonth-picker').datepicker({
      format: "yyyymm",
      minViewMode: 'months', // or 1, 月选择
      startView: 'decade' // or 2, 10年选择
    }).on('changeMonth', function(e) {
      $(e.currentTarget).data('datepicker').hide();
    })
    ;
    $('.timepicker').datetimepicker({
      weekStart: 1,
      todayBtn:  1,
      autoclose: 1,
      todayHighlight: 1,
      startView: 1,
      minView: 0,
      maxView: 1,
      format : "hh:ii:00",
      forceParse: 0
    }).on('input change select', function (e) {
      $(this).valid();
    });

    $('.nominal_uang').priceFormat({
        prefix: '',
        clearPrefix: true,
        centsLimit: 0
    });

    $('.date-time-picker').datetimepicker({
      format: "dd-mm-yyyy hh:ii:ss",
      autoclose: true,
    }).on('input change select', function (e) {
      $(this).valid();
    });;

  </script>

  {% block inline_script %}
  
  {% endblock %}
</body>

</html>