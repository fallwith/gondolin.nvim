# -----------------------------------------------------------------------------
# Gondolin Dark
# Upstream: https://github.com/wunki/gondolin.nvim/blob/main/extras/nushell/gondolin-dark.nu
# URL: https://www.nushell.sh/
# -----------------------------------------------------------------------------

export def main [] {

    return {
        binary: '#FF7A77'
        block: '#83AEF8'
        cell-path: '#D6DAE7'
        closure: '#91D8CE'
        custom: '#D6DAE7'
        duration: '#FFE878'
        float: '#FF7774'
        glob: '#D6DAE7'
        int: '#FF7A77'
        list: '#91D8CE'
        nothing: '#FF7A77'
        range: '#FFE878'
        record: '#91D8CE'
        string: '#B9EC86'

        bool: {|| if $in { '#71FEFF' } else { '#FFE878' } }

        datetime: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#FF7A77' attr: 'b' }
            } else if $in < 6hr {
                '#FF7A77'
            } else if $in < 1day {
                '#FFE878'
            } else if $in < 3day {
                '#B9EC86'
            } else if $in < 1wk {
                { fg: '#B9EC86' attr: 'b' }
            } else if $in < 6wk {
                '#91D8CE'
            } else if $in < 52wk {
                '#83AEF8'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#D6DAE7'
            } else if $e < 1mb {
                '#91D8CE'
            } else {{ fg: '#83AEF8' }}
        }

        shape_and: { fg: '#FF7A77' attr: 'b' }
        shape_binary: { fg: '#FF7A77' attr: 'b' }
        shape_block: { fg: '#83AEF8' attr: 'b' }
        shape_bool: '#71FEFF'
        shape_closure: { fg: '#91D8CE' attr: 'b' }
        shape_custom: '#B9EC86'
        shape_datetime: { fg: '#91D8CE' attr: 'b' }
        shape_directory: '#91D8CE'
        shape_external: '#91D8CE'
        shape_external_resolved: '#71FEFF'
        shape_externalarg: { fg: '#B9EC86' attr: 'b' }
        shape_filepath: '#91D8CE'
        shape_flag: { fg: '#83AEF8' attr: 'b' }
        shape_float: { fg: '#FF7774' attr: 'b' }
        shape_garbage: { fg: '#A2AEC0' bg: '#FF7A77' attr: 'b' } # Keeping red and white for garbage
        shape_glob_interpolation: { fg: '#91D8CE' attr: 'b' }
        shape_globpattern: { fg: '#91D8CE' attr: 'b' }
        shape_int: { fg: '#FF7A77' attr: 'b' }
        shape_internalcall: { fg: '#91D8CE' attr: 'b' }
        shape_keyword: { fg: '#FF7A77' attr: 'b' }
        shape_list: { fg: '#91D8CE' attr: 'b' }
        shape_literal: '#83AEF8'
        shape_match_pattern: '#B9EC86'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#FF7A77'
        shape_operator: '#FFE878'
        shape_or: { fg: '#FF7A77' attr: 'b' }
        shape_pipe: { fg: '#FF7A77' attr: 'b' }
        shape_range: { fg: '#FFE878' attr: 'b' }
        shape_raw_string: { fg: '#D6DAE7' attr: 'b' }
        shape_record: { fg: '#91D8CE' attr: 'b' }
        shape_redirection: { fg: '#FF7A77' attr: 'b' }
        shape_signature: { fg: '#B9EC86' attr: 'b' }
        shape_string: '#B9EC86'
        shape_string_interpolation: { fg: '#91D8CE' attr: 'b' }
        shape_table: { fg: '#83AEF8' attr: 'b' }
        shape_vardecl: { fg: '#83AEF8' attr: 'u' }
        shape_variable: '#FF7A77'

        foreground: '#D0D3DA'
        background: '#080A0D'
        cursor: '#83AEF8'

        empty: '#83AEF8'
        header: { fg: '#B9EC86' attr: 'b' }
        hints: '#3D4550'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#B9EC86' attr: 'b' }
        search_result: { fg: '#FF7A77' bg: '#D6DAE7' }
        separator: '#D6DAE7'
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
  