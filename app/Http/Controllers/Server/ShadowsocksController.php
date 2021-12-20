<?php

namespace App\Http\Controllers\Server;

use App\Http\Controllers\Controller;
use App\Jobs\ServerLogJob;
use App\Jobs\TrafficFetchJob;
use App\Models\Server;
use App\Models\ServerShadowsocks;
use App\Models\User;
use App\Utils\CacheKey;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\Routing\ResponseFactory;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Cache;


class ShadowsocksController extends Controller
{
    /**
     * User
     *
     * @param Request $request
     * @return Application|ResponseFactory|Response
     */
    public function users(Request $request)
    {
        $reqNodeId = (int)$request->input('node_id');
        if ($reqNodeId <= 0) {
            abort(500, '参数错误');
        }

        /**
         * @var ServerShadowsocks $server
         */
        $server = ServerShadowsocks::find($reqNodeId);
        if ($server === null) {
            abort(500, 'server not found');
        }

        Cache::put(CacheKey::get(CacheKey::SERVER_SHADOWSOCKS_LAST_CHECK_AT, $server->getKey()), time(), 3600);

        $result = [];
        $users = $server->findAvailableUsers();
        foreach ($users as $user) {
            /**
             * @var User $user
             */
            array_push($result, [
                User::FIELD_ID => $user->getKey(),
                User::FIELD_UUID => $user->getAttribute(User::FIELD_UUID)
            ]);
        }

        return response([
            'data' => $result
        ]);
    }

    /**
     * 后端提交数据
     *
     * @param Request $request
     * @return Application|ResponseFactory|Response
     */
    public function submit(Request $request)
    {
        $reqNodeId = $request->input('node_id');
        if ($reqNodeId <= 0) {
            abort(500, '参数错误');
        }

        $server = ServerShadowsocks::find($reqNodeId);
        if ($server === null) {
            abort(500, 'server is not found');
        }
        $data = file_get_contents('php://input');

        $data = json_decode($data, true);
        if ($data === null || !is_array($data)) {
            abort(500, 'parse_error');
        }

        Cache::put(CacheKey::get(CacheKey::SERVER_SHADOWSOCKS_ONLINE_USER, $server->getKey()), count($data), 3600);
        Cache::put(CacheKey::get(CacheKey::SERVER_SHADOWSOCKS_LAST_PUSH_AT, $server->getKey()), time(), 3600);


        foreach ($data as $item) {
            $rate = $server->getAttribute(Server::FIELD_RATE);
            $u = $item[User::FIELD_U] * $rate;
            $d = $item[User::FIELD_D] * $rate;
            $userId = $item['user_id'];
            TrafficFetchJob::dispatch($u, $d, $userId);
            ServerLogJob::dispatch($u, $d, $userId, $server->getKey(), $rate, ServerShadowsocks::METHOD);
        }

        return response([
            'data' => true
        ]);
    }

    /**
     * config
     *
     * @param Request $request
     * @return Application|ResponseFactory|Response
     */
    public function config(Request $request)
    {
        $reqNodeId = (int)$request->input('node_id');
        if ($reqNodeId <= 0) {
            abort(500, '参数错误');
        }

        /**
         * @var ServerShadowsocks $server
         */
        $server = ServerShadowsocks::find($reqNodeId);
        if ($server === null) {
            abort(500, 'server not found');
        }

        $data = $server->makeHidden([
            ServerShadowsocks::FIELD_GROUP_ID, ServerShadowsocks::FIELD_PARENT_ID, ServerShadowsocks::FIELD_NAME,
            ServerShadowsocks::FIELD_TAGS, ServerShadowsocks::FIELD_CREATED_AT, ServerShadowsocks::FIELD_SHOW,
            ServerShadowsocks::FIELD_HOST, ServerShadowsocks::FIELD_PORT, ServerShadowsocks::FIELD_CREATED_AT,
            ServerShadowsocks::FIELD_UPDATED_AT, ServerShadowsocks::FIELD_RATE, ServerShadowsocks::FIELD_SORT
        ]);

        return response([
            'data' => $data,
        ]);
    }
}
