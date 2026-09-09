# Material and history schema

## `material-tags.json`

Keep one record per useful source or manually selected time range. Required fields: `asset_id`, `path`, `source_start`, `source_end`, `media_type`, `scene_tags`, `lighting`, `colors`, `control_method`, `app_visible`, `remote_visible`, `hook_strength`, `quality`, `rights`, and `notes`.

Use `unknown` for visual facts not yet reviewed. Folder names alone do not prove that a phone App or remote is absent.

## `usage-history.json`

Append one object per delivered edit with `output_id`, `output_path`, `created_at`, `control_method`, and `shots`. Each shot must contain `shot_id`, `source`, `source_start`, `source_end`, and `role`.

The storyboard must use the same source and time-range fields so diversity checks are reliable.
