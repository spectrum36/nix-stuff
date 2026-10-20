{ pkgs, ... }: {
  services = {
    llama-cpp = {
      enable = false;
      package = pkgs.llama-cpp.override { 
        cudaSupport = true;
      };
      settings = {
        models-preset = (pkgs.formats.ini { }).generate "models-preset.ini"{
          "*" = {
            flash-attn = "on";
            cache-type-k = "q4_0";
            cache-type-v = "q4_0";
            threads = 16;
          };
          "qwen3.6-35b-a3b" = {
            hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF";
            #hf-file = "Qwen3.6-35B-A3B-UD-Q4_K_M.gguf";
            hf-file = "Qwen3.6-35B-A3B-UD-Q6_K.gguf";
            alias = "qwen3.6-35b-a3b";
            ctx-size = "262144";
            rope-scaling = "yarn";
            rope-scale = "2";
            yarn-orig-ctx = "131072";
            temp = "1.0";
            top-p = "0.95";
            top-k = "20";
            min-p = "0.0";
            presence-penalty = "0.0";
          }; 
          "qwen3.5-4b" = {
            hf-repo = "Qwen/Qwen3.5-4B-GGUF";
            hf-file = "Qwen3.5-4B-Q4_K_M.gguf";
            alias = "qwen3-4b";
            ctx-size = "32768";
            temp = "0.6";
            top-p = "0.95";
            top-k = "20";
            presence-penalty = "0.0";
          };
        };
        # router server loads at most 4 models by default; keep all 5 resident
        models-max = 0;
      };
    };
    strata = {
      enable = true;
      family = "qwen";
      model = "IQ3_XXS";
      context = "131072";
      host = "127.0.0.1";
      port = 8090;
      sampling = {
        temperature = 1.0;
        top_p = 0.95;
        top_k = 20;
      };
    };
  };
}
