resource "aws_iam_role" "instance" {
  name = "example-role" # ロール名
  // name_prefix = # 指定値で始まるランダムなロール名
  assume_role_policy    = data.aws_iam_policy_document.instance_assume_role_policy.json # AssumeRole ポリシーのJSON
  description           = "ロールの説明"
  force_detach_policies = true # ロール破棄時にアタッチされたポリシーをデタッチする
  // inline_policy {} # インラインポリシー
  managed_policy_arns = [] # アタッチする管理ポリシーのARNリスト
  // max_session_duration = 3600 # ロールのセッション時間(秒)
  // path = # ロールへのパス
  // permissions_boundary = # アクセス許可境界を設定するポリシーのARN
  tags = {
    tag-key = "tag-value" // タグ
  }
}
