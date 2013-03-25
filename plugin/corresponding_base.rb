class CorrespondingBase
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def basename
    File.basename(file)
  end

  private

  def handle_matches(matches)
    if matches.size == 0
      nil
    elsif matches.size == 1
      matches.first
    else
      closest_path_from_multile_matches(matches)
    end
  end

  def closest_path_from_multile_matches(matches)
    file_dir_parts = dir_parts(file)
    scores = Hash.new(0)

    matches.map do |match|
      [match, dir_parts(match)]
    end.each do | match_data|
      parts = match_data.last
      file_dir_parts.zip(parts).each do | m|
        if m.first == m.last
          scores[match_data.first] += 1
        end
      end
    end
    return nil if scores.empty?
    scores.max_by{|k,v| v}.first
  end

  def dir_parts(f)
    File.dirname(f).split('/').reverse
  end
end
