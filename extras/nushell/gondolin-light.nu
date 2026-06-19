# -----------------------------------------------------------------------------
# Gondolin Light
# Upstream: https://github.com/wunki/gondolin.nvim/blob/main/extras/nushell/gondolin-light.nu
# URL: https://www.nushell.sh/
# -----------------------------------------------------------------------------

export def main [] {

    return {
        binary: '#aa544d'
        block: '#46778d'
        cell-path: '#f4efe6'
        closure: '#477f5e'
        custom: '#f4efe6'
        duration: '#aa5f1b'
        float: '#bb625b'
        glob: '#f4efe6'
        int: '#aa544d'
        list: '#477f5e'
        nothing: '#aa544d'
        range: '#aa5f1b'
        record: '#477f5e'
        string: '#637827'

        bool: {|| if $in { '#53879e' } else { '#aa5f1b' } }

        datetime: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#aa544d' attr: 'b' }
            } else if $in < 6hr {
                '#aa544d'
            } else if $in < 1day {
                '#aa5f1b'
            } else if $in < 3day {
                '#637827'
            } else if $in < 1wk {
                { fg: '#637827' attr: 'b' }
            } else if $in < 6wk {
                '#477f5e'
            } else if $in < 52wk {
                '#46778d'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#f4efe6'
            } else if $e < 1mb {
                '#477f5e'
            } else {{ fg: '#46778d' }}
        }

        shape_and: { fg: '#aa544d' attr: 'b' }
        shape_binary: { fg: '#aa544d' attr: 'b' }
        shape_block: { fg: '#46778d' attr: 'b' }
        shape_bool: '#53879e'
        shape_closure: { fg: '#477f5e' attr: 'b' }
        shape_custom: '#637827'
        shape_datetime: { fg: '#477f5e' attr: 'b' }
        shape_directory: '#477f5e'
        shape_external: '#477f5e'
        shape_external_resolved: '#53879e'
        shape_externalarg: { fg: '#637827' attr: 'b' }
        shape_filepath: '#477f5e'
        shape_flag: { fg: '#46778d' attr: 'b' }
        shape_float: { fg: '#bb625b' attr: 'b' }
        shape_garbage: { fg: '#829181' bg: '#aa544d' attr: 'b' } # Keeping red and white for garbage
        shape_glob_interpolation: { fg: '#477f5e' attr: 'b' }
        shape_globpattern: { fg: '#477f5e' attr: 'b' }
        shape_int: { fg: '#aa544d' attr: 'b' }
        shape_internalcall: { fg: '#477f5e' attr: 'b' }
        shape_keyword: { fg: '#aa544d' attr: 'b' }
        shape_list: { fg: '#477f5e' attr: 'b' }
        shape_literal: '#46778d'
        shape_match_pattern: '#637827'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#aa544d'
        shape_operator: '#aa5f1b'
        shape_or: { fg: '#aa544d' attr: 'b' }
        shape_pipe: { fg: '#aa544d' attr: 'b' }
        shape_range: { fg: '#aa5f1b' attr: 'b' }
        shape_raw_string: { fg: '#f4efe6' attr: 'b' }
        shape_record: { fg: '#477f5e' attr: 'b' }
        shape_redirection: { fg: '#aa544d' attr: 'b' }
        shape_signature: { fg: '#637827' attr: 'b' }
        shape_string: '#637827'
        shape_string_interpolation: { fg: '#477f5e' attr: 'b' }
        shape_table: { fg: '#46778d' attr: 'b' }
        shape_vardecl: { fg: '#46778d' attr: 'u' }
        shape_variable: '#aa544d'

        foreground: '#5c6a72'
        background: '#f4efe6'
        cursor: '#46778d'

        empty: '#46778d'
        header: { fg: '#637827' attr: 'b' }
        hints: '#879484'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#637827' attr: 'b' }
        search_result: { fg: '#aa544d' bg: '#f4efe6' }
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
  