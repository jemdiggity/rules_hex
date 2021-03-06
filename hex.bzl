#Credit to https://github.com/schmist/

def _impl(ctx):
    output = ctx.outputs.out
    input = ctx.file.src
    objcopy = ctx.fragments.cpp.objcopy_executable

    ctx.action(
        inputs=[input],
        outputs=[output],
        progress_message="Creating HEX binary from %s" % input.short_path,
        command="%s -O ihex %s %s" % (objcopy, input.path, output.path))

hex = rule(
    implementation=_impl,
    fragments=["cpp"],
    attrs={
        "src": attr.label(mandatory=True, allow_files=True, single_file=True),
        "show_size": attr.bool(mandatory=False, default=False),
    },
    outputs={"out": "%{src}.hex"},
)
