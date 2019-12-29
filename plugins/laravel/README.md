# Laravel

Enable some cool aliases for Laravel [artisan console](https://laravel.com/docs/5.7/artisan). To use it, add `laravel` to the plugins array of your zshrc file:
```
plugins=(... laravel)
```

| Alias | Description |
|:-:|:-:|
| `artisan`  | `php artisan`  |
| `pas`  | `php artisan serve` |

## Database

| Alias | Description |
|:-:|:-:|
| `pam`  |  `php artisan migrate` |
| `pamf`  |  `php artisan migrate:fresh` |
| `pamfs`  |  `php artisan migrate:fresh --seed` |
| `pamr`  |  `php artisan migrate:rollback` |
| `pads`  |  `php artisan db:seed` |

## Makers

| Alias | Description |
|:-:|:-:|
| `pamm`  |  `php artisan make:model` |
| `pamc`  |  `php artisan make:controller` |
| `pams`  |  `php artisan make:seeder` |
| `pamt`  |  `php artisan make:test` |
| `pamfa`  |  `php artisan make:factory` |
| `pamp`  |  `php artisan make:policy` |
| `pame`  |  `php artisan make:event` |
| `pamj`  |  `php artisan make:job` |
| `paml`  |  `php artisan make:listener` |
| `pamn`  |  `php artisan make:notification` |

## Clears

| Alias | Description |
|:-:|:-:|
| `pacac`  |  `php artisan cache:clear` |
| `pacoc`  |  `php artisan config:clear` |
| `pavic`  |  `php artisan view:clear` |
| `paroc`  |  `php artisan route:clear` |
# Laravel plugin

This plugin adds aliases and autocompletion for Laravel [Artisan](https://laravel.com/docs/artisan) and [Bob](http://daylerees.github.io/laravel-bob/) command-line interfaces.

**NOTE:** completion might not work for recent Laravel versions since it hasn't been updated since 2012.
In that case, check out plugins `laravel4` and `laravel5`.

To use it, add `laravel` to the plugins array in your zshrc file:

```zsh
plugins=(... laravel)
```

## Aliases

| Alias     | Command                  | Description          |
|-----------|--------------------------|----------------------|
| artisan   | `php artisan`            | Main Artisan command |
| bob       | `php artisan bob::build` | Main Bob command     |
>>>>>>> laravel: add README (#7222)
=======

## Queues

| Alias | Description |
|:-:|:-:|
| `paqf`  |  `php artisan queue:failed` |
| `paqft`  |  `php artisan queue:failed-table` |
| `paql`  |  `php artisan queue:listen` |
| `paqr`  |  `php artisan queue:retry` |
| `paqt`  |  `php artisan queue:table` |
| `paqw`  |  `php artisan queue:work` |
