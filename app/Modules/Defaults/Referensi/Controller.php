<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Referensi;

use App\Modules\Defaults\Referensi\Model\Anggota;
use App\Modules\Defaults\Referensi\Model\Kategori;
use App\Modules\Defaults\Referensi\Model\Role;
use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Referensi\Model\Penerbit;
use App\Modules\Defaults\Referensi\Model\Penulis;

use Core\Facades\Request;

/**
 * @routeGroup('/referensi')
 */
class Controller extends BaseController
{
	/**
	 * @routePost('/getKategori')
	 * @routeGet('/getKategori')
	 */
	public function getKategoriAction()
	{
		$nama = $this->request->get('q');
		$page = $this->request->get('page');
		$offset = ($page - 1) * 20;

		$data = Kategori::find(
			array(
				"limit" => 21,
				"offset" => $offset,
				"conditions" => "nama LIKE '%$nama%'",
			)
		);

		$data_array = $data->toArray();
		$has_more = count($data_array) > 20;

		$json_data = [
			"data" => $data_array,
			"has_more" => $has_more,
		];

		echo json_encode($json_data);
	}
	/**
	 * @routePost('/getRole')
	 * @routeGet('/getRole')
	 */
	public function getRoleAction()
	{
		$search = $this->request->get('q');
		$page = $this->request->get('page');
		$offset = ($page - 1) * 20;

		$data = Role::find(
			array(
				"limit" => 21,
				"offset" => $offset,
				"conditions" => "role LIKE '%$search%'",
			)
		);

		$data_array = $data->toArray();
		$has_more = count($data_array) > 20;

		$json_data = [
			"data" => $data_array,
			"has_more" => $has_more,
		];

		echo json_encode($json_data);
	}
	/**
	 * @routePost('/getPenulis')
	 * @routeGet('/getPenulis')
	 */
	public function getPenulisAction()
	{
		$search = $this->request->get('q');
		$page = $this->request->get('page');
		$offset = ($page - 1) * 20;

		$data = Penulis::find(
			array(
				"limit" => 21,
				"offset" => $offset,
				"conditions" => "nama LIKE '%$search%'",
			)
		);

		$data_array = $data->toArray();
		$has_more = count($data_array) > 20;

		$json_data = [
			"data" => $data_array,
			"has_more" => $has_more,
		];

		echo json_encode($json_data);
	}
	/**
	 * @routePost('/getPenerbit')
	 * @routeGet('/getPenerbit')
	 */
	public function getPenerbitAction()
	{
		$search = $this->request->get('q');
		$page = $this->request->get('page');
		$offset = ($page - 1) * 20;

		$data = Penerbit::find(
			array(
				"limit" => 21,
				"offset" => $offset,
				"conditions" => "nama LIKE '%$search%'",
			)
		);

		$data_array = $data->toArray();
		$has_more = count($data_array) > 20;

		$json_data = [
			"data" => $data_array,
			"has_more" => $has_more,
		];

		echo json_encode($json_data);
	}
	/**
	 * @routePost('/getAnggota')
	 * @routeGet('/getAnggota')
	 */
	public function getAnggotaAction()
	{
		$search = $this->request->get('q');
		$page = $this->request->get('page');
		$offset = ($page - 1) * 20;

		$data = Anggota::find(
			array(
				"limit" => 21,
				"offset" => $offset,
				"conditions" => "nama LIKE '%$search%'",
			)
		);

		$data_array = $data->toArray();
		$has_more = count($data_array) > 20;

		$json_data = [
			"data" => $data_array,
			"has_more" => $has_more,
		];

		echo json_encode($json_data);
	}
}