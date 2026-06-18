# -----------------------------------------------------------------------------
# Gondolin Light
# Upstream: https://github.com/wunki/gondolin.nvim/main/extras/nushell/gondolin-light.nu
# URL: https://www.nushell.sh/
# -----------------------------------------------------------------------------

export def main [] {

    return {
        binary: '#b4545b'
        block: '#4a6890'
        cell-path: '#f4efe6'
        closure: '#356b7f'
        custom: '#f4efe6'
        duration: '#9f6c1f'
        float: '#c96369'
        glob: '#f4efe6'
        int: '#b4545b'
        list: '#356b7f'
        nothing: '#b4545b'
        range: '#9f6c1f'
        record: '#356b7f'
        string: '#3f8d58'

        bool: {|| if $in { '#5778a5' } else { '#9f6c1f' } }

        datetime: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#b4545b' attr: 'b' }
            } else if $in < 6hr {
                '#b4545b'
            } else if $in < 1day {
                '#9f6c1f'
            } else if $in < 3day {
                '#3f8d58'
            } else if $in < 1wk {
                { fg: '#3f8d58' attr: 'b' }
            } else if $in < 6wk {
                '#356b7f'
            } else if $in < 52wk {
                '#4a6890'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#f4efe6'
            } else if $e < 1mb {
                '#356b7f'
            } else {{ fg: '#4a6890' }}
        }

        shape_and: { fg: '#b4545b' attr: 'b' }
        shape_binary: { fg: '#b4545b' attr: 'b' }
        shape_block: { fg: '#4a6890' attr: 'b' }
        shape_bool: '#5778a5'
        shape_closure: { fg: '#356b7f' attr: 'b' }
        shape_custom: '#3f8d58'
        shape_datetime: { fg: '#356b7f' attr: 'b' }
        shape_directory: '#356b7f'
        shape_external: '#356b7f'
        shape_external_resolved: '#5778a5'
        shape_externalarg: { fg: '#3f8d58' attr: 'b' }
        shape_filepath: '#356b7f'
        shape_flag: { fg: '#4a6890' attr: 'b' }
        shape_float: { fg: '#c96369' attr: 'b' }
        shape_garbage: { fg: '${fg.dim}' bg: '#b4545b' attr: 'b' } # Keeping red and white for garbage
        shape_glob_interpolation: { fg: '#356b7f' attr: 'b' }
        shape_globpattern: { fg: '#356b7f' attr: 'b' }
        shape_int: { fg: '#b4545b' attr: 'b' }
        shape_internalcall: { fg: '#356b7f' attr: 'b' }
        shape_keyword: { fg: '#b4545b' attr: 'b' }
        shape_list: { fg: '#356b7f' attr: 'b' }
        shape_literal: '#4a6890'
        shape_match_pattern: '#3f8d58'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#b4545b'
        shape_operator: '#9f6c1f'
        shape_or: { fg: '#b4545b' attr: 'b' }
        shape_pipe: { fg: '#b4545b' attr: 'b' }
        shape_range: { fg: '#9f6c1f' attr: 'b' }
        shape_raw_string: { fg: '#f4efe6' attr: 'b' }
        shape_record: { fg: '#356b7f' attr: 'b' }
        shape_redirection: { fg: '#b4545b' attr: 'b' }
        shape_signature: { fg: '#3f8d58' attr: 'b' }
        shape_string: '#3f8d58'
        shape_string_interpolation: { fg: '#356b7f' attr: 'b' }
        shape_table: { fg: '#4a6890' attr: 'b' }
        shape_vardecl: { fg: '#4a6890' attr: 'u' }
        shape_variable: '#b4545b'

        foreground: '#2f2417'
        background: '#f4efe6'
        cursor: '${ui.cursor}'

        empty: '#4a6890'
        header: { fg: '#3f8d58' attr: 'b' }
        hints: '#8f7a65'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#3f8d58' attr: 'b' }
        search_result: { fg: '#b4545b' bg: '#f4efe6' }
        separator: '#f4efe6'
    }
}

# Update the Nushell configuration
export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

# Update terminal colors
export def "update terminal" [] {
    let theme = (main)

    # Set terminal colors
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'
        
    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    # Line breaks above are just for source readability
    # but create extra whitespace when activating. Collapse
    # to one line and print with no-newline
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

# Activate the theme when sourced
use activate
  