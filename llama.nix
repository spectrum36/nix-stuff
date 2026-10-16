{ pkgs, ... }: {
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp.override { cudaSupport = true; };
    settings = {
      models-preset = (pkgs.formats.ini { }).generate "models-preset.ini"{
        "qwen3.8-27b" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          hf-file = "Qwen3.8-27B-UD-Q4_K_M.gguf";
          alias = "qwen3.8-27b";
          temp = "0.2";
          repeat-penalty = "1.05";
          top-k = "80";
          ctx-size = "48000";
          spec-type = "draft-mtp";
          flash-attn = "on";
          cache-type-k = "q4_0";
          cache-type-v = "q4_0";
        };
        "qwen3-coder-30b" = {
          hf-repo = "Qwen/Qwen3-30B-A3B-GGUF";
          hf-file = "Qwen3-Coder-30B-A3B-Q4_K_M.gguf";
          alias = "qwen3-coder";
          ctx-size = "100000";
        };
        "qwen3-4b" = {
          hf-repo = "Qwen/Qwen3-4B-GGUF";
          hf-file = "Qwen3-4B-Q4_K_M.gguf";
          alias = "qwen3-4b";
        };
      };
    };
  };
}
