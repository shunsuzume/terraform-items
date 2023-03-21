resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16" # IPv4 CIDR ブロック
  // instance_tenancy = "default" # テナンシー
  // ipv4_ipam_pool_id = # IPv4 IPAM プール
  // ipv4_netmask_length = # ネットマスク
  // ipv6_cidr_block = # IPv6 プール CIDR
  // ipv6_ipam_pool_id = # IPv6 IPAM プール
  // ipv6_netmask_length = # IPv6 ネットマスク
  // ipv6_cidr_block_network_border_group = # ネットワークボーダーグループ
  // enable_dns_support = true # DNS解決を有効化
  // enable_network_address_usage_metrics = false # Network Address Usageを有効化
  enable_dns_hostnames = true # DNSホスト名を有効化
  // enable_classiclink = false # ClassicLinkを有効化
  // enable_classiclink_dns_support = # ClassicLink DNS解決を有効化
  // assign_generated_ipv6_cidr_block = false # IPv6割り当てのリクエスト
  tags = {
    Name = "example-vpc" # タグ
  }
}

resource "aws_subnet" "example" {
  vpc_id = aws_vpc.example.id # VPC ID
  // assign_ipv6_address_on_creation = false # IPv6割り当てを有効化
  availability_zone = "ap-northeast-1a" # AZ
  // availability_zone_id = # AZ ID
  cidr_block = "10.0.0.0/24" # IPv4 CIDR ブロック
  // customer_owned_ipv4_pool = # IPv4アドレスプール
  // enable_dns64 = false # DNS64を有効化
  // enable_resource_name_dns_aaaa_record_on_launch = false # DNS AAAAレコードを使用した応答の有効化 
  // enable_resource_name_dns_a_record_on_launch = false # DNS Aレコードを使用した応答の有効化
  // ipv6_cidr_block = # IPv6 プール CIDR
  // ipv6_native = false # IPv6専用サブネットの作成s
  // map_customer_owned_ip_on_launch = false # NW Interfaceへの個人所有IPの割り当て
  // map_public_ip_on_launch = false # サブネット内インスタンスへのパブリックIP割り当て
  // outpost_arn = # OutpostのARN
  // private_dns_hostname_type_on_launch = # サブネット内インスタンスへ割り当てるホスト名タイプ
  tags = {
    Name = "example-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.example.id # VPC ID

  tags = {
    Name = "example-ig" # タグ
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id # VPC ID
  // propagating_vgws = # 伝播用仮想ゲートウェイリスト

  tags = {
    Name = "example-rt" # タグ
  }
}

resource "aws_route" "r" {
  route_table_id         = aws_route_table.example.id # ルートテーブルID
  destination_cidr_block = "0.0.0.0/0"                # 宛先CIDRブロック 
  // destination_ipv6_cidr_block = # 宛先IPv6 CIDRブロック
  // destination_prefix_list_id = # マネージドプレフィックスリストの宛先ID
  // carrier_gateway_id = # Carrier Gateway ID
  // core_network_arn = # コアネットワークのARN
  // egress_only_gateway_id = # Egress Only Internet GatewayのID
  gateway_id = aws_internet_gateway.gw.id # Internet GatewayのID
  // nat_gateway_id = # NAT GatewayのID
  // local_gateway_id = # Outpost ローカルゲートウェイのID
  // network_interface_id = # EC2 ネットワークインターフェースのID
  // transit_gateway_id = # EC2 Transit GatewayのID
  // vpc_endpoint_id = # VPCエンドポイントのID
  // vpc_peering_connection_id = # VPCピアリング接続のID
}

resource "aws_route_table_association" "example" {
  subnet_id = aws_subnet.example.id # サブネットのID
  // gateway_id = # GatewayのID
  route_table_id = aws_route_table.example.id # ルートテーブルのID
}

