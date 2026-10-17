{ pkgs, ... }: {
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp.override { cudaSupport = true; };
    settings = {
      models-preset = (pkgs.formats.ini { }).generate "models-preset.ini"{
        "*" = {
          flash-attn = "on";
          cache-type-k = "q4_0";
          cache-type-v = "q4_0";
        };
        "qwen3.8-27b" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          hf-file = "Qwen3.8-27B-UD-Q4_K_M.gguf";
          alias = "qwen3.8-27b";
          ctx-size = "131072";
          spec-type = "draft-mtp";
          temp = "1.0";
          top-p = "0.95";
          top-k = "20";
          min-p = "0.0";
          presence-penalty = "0.0";
          #repetition-penalty = "1.0";
        };
        "qwen3-30b" = {
          hf-repo = "Qwen/Qwen3-30B-A3B-GGUF";
          hf-file = "Qwen3-30B-A3B-Q4_K_M.gguf";
          alias = "qwen3-30b";
          ctx-size = "48000";
        };
        "qwen3-coder" = {
          hf-repo = "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF";
          hf-file = "Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf";
          alias = "qwen3-coder";
          ctx-size = "48000";
        };
        "qwen3-4b" = {
          hf-repo = "Qwen/Qwen3-4B-GGUF";
          hf-file = "Qwen3-4B-Q4_K_M.gguf";
          alias = "qwen3-4b";
          ctx-size = "32768";
        };
      };
    };
  };
}
