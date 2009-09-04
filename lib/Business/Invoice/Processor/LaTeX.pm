use MooseX::Declare;

class Business::Invoice::Processor::LaTeX extends Business::Invoice::Processor::TemplateAlloy {
    use Encode;
    
    has format =>  ( is => 'rw', isa => 'Str', default => 'pdf' );
    
    around process() {
        $self->_processor->define_vmethod('text',  escape => \&_escape);
        return $self->$orig();
    }
    
    sub _escape {
        my $text = shift;
        $text =~ s/\n/\n\n/g;
        $text =~ s/\\/\\textbackslash /g;
        for('{', '}', '&' ,'%', '_', '$', '#') {
            $text =~ s/\Q$_\E/\\$_/g;
        }
        $text =~ s/\^/\\textasciicircum/g;
        $text =~ s/\~/\\textasciitilde/g;
        $text = encode('utf8', $text);
        return $text;
    }
    
}
