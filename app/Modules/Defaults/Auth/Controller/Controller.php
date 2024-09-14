<?php

declare(strict_types=1);

namespace App\Modules\Defaults\Auth\Controller;

use App\Modules\Defaults\Auth\Model\PdamModel;
use Core\Facades\Session;
use Core\Facades\Response;
use Core\Facades\Request;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\Controller as BaseController;
use App\Modules\Defaults\Auth\Model\UsersModel;
use Core\Facades\Dispatcher as FacadesDispatcher;
use Core\Facades\Request as FacadesRequest;
use Core\Facades\Security;

/**
 * @routeGroup("/auth")
 */
class Controller extends BaseController
{

    /**
     * @route(["GET", "POST"], "/")
     */
    public function indexAction()
    {
        return FacadesDispatcher::forward([
            'controller' => 'Defaults\Auth',
            'action'     => FacadesRequest::isPost() ? 'doLogin' : 'login',
        ]);
    }

    /**
     * @routeGet("/login")
     */
    public function loginAction()
    {
        $this->view->setMainView('Defaults/Auth/login');
    }

    /**
     * @routeGet("/unauthorized")
     */
    public function unauthorizedAction()
    {
        $this->view->setMainView('Errors/unauthorized');
    }

    /**
     * @routePost("/login")
     */
    public function doLoginAction()
    {
        // echo "<pre>";
        // print_r($this->request->getPost());
        // echo "</pre>";
        // die();
        $username = Request::getPost('username');
        $password = Request::getPost('password');
        $tahun = Request::getPost('tahun');
        $user = UsersModel::findFirstByUsername($username);
        if (!isset($user->password)) {
            return Response::redirect('/panel/auth/login?wp=true');
        }
        if (!isset($username) || ($password != $user->password)) {
            return Response::redirect('/panel/auth/login?wp=true');
        }

        $userdata = array(
            'id'            => $user->id,
            'nama'          => $user->nama,
            'username'      => $user->username,
            'id_role'       => $user->id_role,
            'tahun'         => $tahun,
        );

        Session::set('user', $userdata);

        $intended = Session::get('intended') ?? '/panel/dashboard';
        Session::remove('intended');

        return Response::redirect($intended);
    }


    /**
     * @routeGet('/logout')
     * @middleware('RequireUser')
     */
    public function logoutAction()
    {
        Session::remove('user');
        return Response::redirect("/panel/auth/login");
    }
}