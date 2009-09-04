use Test::LoadAllModules;

BEGIN {
    all_uses_ok( search_path => 'Business::Invoice::Processor::LaTeX' );
}
