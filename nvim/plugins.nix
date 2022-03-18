{ pkgs, lib }:
{
  filetype = pkgs.vimUtils.buildVimPlugin rec {
    pname = "filetype";
    version = "v0.4";
    src = pkgs.fetchFromGitHub {
      owner = "nathom";
      repo = "filetype.nvim";
      rev = "25b5f7e5314d5e7739be726860253c67f7e513bf";
      sha256 = "1nmpvnqlw4y2g1ki33nbj74vdnaxnaqshqv3238zxgvps44y3mw5";
    };
    meta.homepage = "https://github.com/nathom/filetype.nvim";
  };
}
