<?php




namespace App\Models;

use Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;


/**
 * App\Models\ServerGroup
 *
 * @property int $id
 * @property string $name
 * @property int $created_at
 * @property int $updated_at
 * @method static Builder|ServerGroup newModelQuery()
 * @method static Builder|ServerGroup newQuery()
 * @method static Builder|ServerGroup query()
 * @method static Builder|ServerGroup whereCreatedAt($value)
 * @method static Builder|ServerGroup whereId($value)
 * @method static Builder|ServerGroup whereName($value)
 * @method static Builder|ServerGroup whereUpdatedAt($value)
 * @mixin Eloquent
 */
class ServerGroup extends Model
{
    const FIELD_ID = "id";
    const FIELD_NAME = "name";
    const FIELD_CREATED_AT = "created_at";
    const FIELD_UPDATED_AT = "updated_at";

    protected $table = 'server_group';
    protected $dateFormat = 'U';

    protected $casts = [
        self::FIELD_CREATED_AT => 'timestamp',
        self::FIELD_UPDATED_AT => 'timestamp'
    ];
}
