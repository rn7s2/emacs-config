;; 缩进4格，采用linux代码风格
(setq c-basic-offset 4)
(setq c-default-style "linux")

;; 传递给clang的参数，用于自动补全
(setq company-clang-arguments '("-I/usr/local/include/json-glib-1.0"
                                "-I/usr/local/include"
                                "-I/usr/local/include/glib-2.0"
                                "-I/usr/local/lib/glib-2.0/include"
                                "-pthread"))
