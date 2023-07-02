GO_MOD_NAME := $(shell grep -m 1 'module ' go.mod | cut -d' ' -f2)
GO_MOD_DOMAIN := $(shell echo $(GO_MOD_NAME) | awk -F '/' '{print $$1}')
PROJECT_NAME := $(shell grep 'module ' go.mod | awk '{print $$2}' | sed 's|$(GO_MOD_DOMAIN)/||g')

.PHONY: fmt
# 代码格式化
fmt:
	@gofumpt -version || go install mvdan.cc/gofumpt@latest
	gofumpt -extra -w -d .
	@gci -v || go install github.com/daixiang0/gci@latest
	gci write -s standard -s default -s 'Prefix($(GO_MOD_DOMAIN))' --skip-generated .