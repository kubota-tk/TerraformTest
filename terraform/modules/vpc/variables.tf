##変数は、モジュール側であっても定義
##全体に必要な変数はenvにも定義

variable "project_name" {}


//////// network ////////
//envのmainで、モジュール定義して同変数を上書き
//開発環境別でネットワーク変更できるようにした

variable "vpccidr" {}

variable "public_subnet_acidr" {}

variable "public_subnet_ccidr" {}

variable "private_subnet_acidr" {}

variable "private_subnet_ccidr" {}

