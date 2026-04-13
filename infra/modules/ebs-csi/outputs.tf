output "ebs_csi_role_arn" {
  value = aws_iam_role.ebs_csi.arn
}

output "ebs_csi_addon_name" {
  value = aws_eks_addon.ebs_csi.addon_name
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}