output "rendered" {
  value       = data.template_file.tamr_config.rendered
  description = "Rendered yaml Tamr config"
}
