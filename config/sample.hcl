# [Required] listener defines how goldfish will listen to incoming connections
listener "tcp" {
	# [Required] [Format: "address", "address:port", or ":port"]
	# The address and port at which goldfish will listen from
	# For production, simply ":443" would be just fine (default https)
	address       = "127.0.0.1:8000"

	# [Required (unless tls_disable == 1)] the certificate file
	tls_cert_file = ""

	# [Required (unless tls_disable == 1)] the private key file
	tls_key_file  = ""

	# [Optional] [Default: 0] [Allowed values: 0, 1]
	# Set this to 1 to disable HTTPS for goldfish listener
	# Leave this empty or equal to 0 unless you know exactly what you're doing
	tls_disable   = 1

	# [Optional] [Default: 0] [Allowed values: 0, 1]
	# If this is set to 1, goldfish will redirect port 80 to port 443
	tls_autoredirect = 0

	# [EXPERIMENTAL] [Optional]
	# This is the vault pki backend path from which Goldfish will fetch its
	# https certs from. New certificates will be requested at half-life at the same path
	# This should be a full path. E.g. "pki/issue/<role_name>"
	# Note this setting _requires_ bootstrapping to be done at launch time!
	tls_pki_path = ""
}

# [Required] vault defines how goldfish should bootstrap to vault
vault {
	# [Required] [Format: "protocol://address:port"]
	# This is vault's address. Vault must be up before goldfish is deployed!
	address         = "http://127.0.0.1:8200"

	# [Optional] [Default: 0] [Allowed values: 0, 1]
	# Set this to 1 to skip verifying the certificate of vault (e.g. self-signed certs)
	tls_skip_verify = 0

	# [Required] [Default: "secret/goldfish"]
	# This should be a generic secret endpoint where runtime settings are stored
	# See wiki for what key values are required in this
	runtime_config  = "secret/goldfish"

	# [Optional] [Default: "auth/approle/login"]
	# You can omit this, unless you mounted approle somewhere weird
	approle_login   = "auth/approle/login"

	# [Optional] [Default: "goldfish"]
	# You can omit this if you already customized the approle ID to be 'goldfish'
	approle_id      = "goldfish"
}

# [Optional] [Default: 0] [Allowed values: 0, 1]
# Set to 1 to disable mlock. Implementation is similar to vault - see vault docs for details
# This option will be ignored on unsupported platforms (e.g Windows)
disable_mlock = 0
