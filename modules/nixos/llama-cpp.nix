{ pkgs, ... }: {
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp.override { vulkanSupport = true; };
    settings = {
      host = "127.0.0.1";
      port = 8012;
      hf-repo = "bartowski/Qwen2.5-Coder-3B-GGUF:Q6_K";
      n-gpu-layers = 99;
      ctx-size = 8192;
      parallel = 1;
      batch-size = 1024;
      ubatch-size = 512;
      cache-reuse = 256;
    };
  };
}
